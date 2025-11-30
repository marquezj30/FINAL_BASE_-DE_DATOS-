import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class MenuReservas {

    public static void mostrar() {
        Scanner sc = new Scanner(System.in);
        int opcion;

        do {
            System.out.println("\n--- GESTIÓN DE RESERVAS & TRANSACCIONES ---");
            System.out.println("1. Nueva Reserva (Ver Mapa de Asientos)");
            System.out.println("2. Ver Mis Reservas");
            System.out.println("0. Volver");
            System.out.print("Opción: ");
            
            opcion = sc.nextInt();
            
            switch (opcion) {
                case 1:
                    iniciarProcesoReserva();
                    break;
                case 2:
                    listarReservasPorCliente();
                    break;
            }
        } while (opcion != 0);
    }

    private static void iniciarProcesoReserva() {
        Scanner sc = new Scanner(System.in);

        // PASO 1: Identificar al Cliente
        System.out.print("\nIngrese su ID de Cliente (ej: 1): ");
        int idCliente = sc.nextInt();

        // PASO 2: Elegir Vuelo
        System.out.print("Ingrese el ID del Vuelo deseado (ej: 1): ");
        long idVuelo = sc.nextLong();

        // PASO 3: Mostrar Mapa de Asientos (Visual)
        mostrarMapaAsientos(idVuelo);

        // PASO 4: Elegir Asiento
        System.out.print("\nIngrese el NÚMERO del asiento a reservar (ej: 3C): ");
        String numeroAsiento = sc.next();

        // PASO 5: LA TRANSACCIÓN CRÍTICA (Bloqueo Pesimista)
        realizarTransaccionReserva(idCliente, idVuelo, numeroAsiento);
    }

    private static void mostrarMapaAsientos(long idVuelo) {
        String sql = "SELECT numero_asiento, disponible FROM asiento WHERE id_vuelo = ? ORDER BY numero_asiento";

        try (Connection conn = ConexionPostgres.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, idVuelo);
            ResultSet rs = stmt.executeQuery();

            System.out.println("\n--- MAPA DE ASIENTOS (Vuelo " + idVuelo + ") ---");
            System.out.println("[ XX ] = Ocupado  |  [ 1A ] = Libre");
            System.out.println("----------------------------------------");

            int contador = 0;
            boolean hayAsientos = false;

            while (rs.next()) {
                hayAsientos = true;
                String asiento = rs.getString("numero_asiento");
                boolean disponible = rs.getBoolean("disponible");

                // Dibujo visual del asiento
                if (disponible) {
                    System.out.print("[ " + asiento + " ] "); 
                } else {
                    System.out.print("[ XX ] "); // Asiento ocupado
                }

                // Salto de línea cada 3 asientos para simular el pasillo/filas
                contador++;
                if (contador % 3 == 0) {
                    System.out.println(); // Salto de fila
                }
            }
            System.out.println("\n----------------------------------------");
            
            if (!hayAsientos) {
                System.out.println("⚠ ALERTA: No se encontraron asientos configurados para este vuelo.");
                System.out.println("Sugerencia: Inserte asientos en la base de datos para el vuelo " + idVuelo);
            }

        } catch (SQLException e) {
            System.out.println(" Error al cargar mapa: " + e.getMessage());
        }
    }

    private static void realizarTransaccionReserva(int idCliente, long idVuelo, String numeroAsiento) {
        Connection conn = null;
        PreparedStatement stmtLock = null;
        PreparedStatement stmtInsert = null;
        PreparedStatement stmtUpdate = null;
        PreparedStatement stmtPago = null;

        try {
            conn = ConexionPostgres.conectar();
            
            // 1. INICIO DE TRANSACCIÓN (ACID)
            // Desactivamos el commit automático. Nada se guarda hasta el final.
          
            conn.setAutoCommit(false);
            System.out.println("\n Iniciando Transacción Segura...");

            // ---------------------------------------------------------
            // 2. BLOQUEO PESIMISTA (SELECT ... FOR UPDATE)
            // REQUISITO CLAVE DEL PROYECTO
            // Esto "cierra" la fila del asiento. Nadie más puede reservarlo mientras nos encontramos en este paso. 
            String sqlLock = "SELECT id_asiento, disponible FROM asiento WHERE id_vuelo = ? AND numero_asiento = ? FOR UPDATE";
            stmtLock = conn.prepareStatement(sqlLock);
            stmtLock.setLong(1, idVuelo);
            stmtLock.setString(2, numeroAsiento);
            
            ResultSet rs = stmtLock.executeQuery();

            if (!rs.next()) {
                System.out.println("Error: El asiento " + numeroAsiento + " no existe en este vuelo.");
                conn.rollback(); // Cancelar todo
                return;
            }

            long idAsiento = rs.getLong("id_asiento");
            boolean disponible = rs.getBoolean("disponible");

            // Validar disponibilidad
            if (!disponible) {
                System.out.println(" LO SENTIMOS: El asiento " + numeroAsiento + " ya está ocupado.");
                conn.rollback(); // Liberar el candado
                return;
            }

            // ---------------------------------------------------------
            // 3. CREAR LA RESERVA
            // ---------------------------------------------------------
            String sqlInsert = "INSERT INTO reserva (id_cliente, id_vuelo, id_asiento, estado) VALUES (?, ?, ?, 'CONFIRMADA') RETURNING id_reserva";
            // Nota: "RETURNING id_reserva" es un truco de Postgres para obtener el ID generado al instante
            stmtInsert = conn.prepareStatement(sqlInsert); 
            stmtInsert.setInt(1, idCliente);
            stmtInsert.setLong(2, idVuelo);
            stmtInsert.setLong(3, idAsiento);
            
            ResultSet rsReserva = stmtInsert.executeQuery();
            long idReservaGenerada = 0;
            if (rsReserva.next()) {
                idReservaGenerada = rsReserva.getLong("id_reserva");
            }

            // ---------------------------------------------------------
            // 4. ACTUALIZAR EL ASIENTO A "OCUPADO"
            // ---------------------------------------------------------
            String sqlUpdate = "UPDATE asiento SET disponible = false WHERE id_asiento = ?";
            stmtUpdate = conn.prepareStatement(sqlUpdate);
            stmtUpdate.setLong(1, idAsiento);
            stmtUpdate.executeUpdate();


            // 5. REGISTRAR EL PAGO AUTOMÁTICO (Simulado)
            String sqlPago = "INSERT INTO pago (id_reserva, monto, metodo_pago) VALUES (?, 250.00, 'TARJETA_CREDITO')";
            stmtPago = conn.prepareStatement(sqlPago);
            stmtPago.setLong(1, idReservaGenerada);
            stmtPago.executeUpdate();

            // 6. COMMIT FINAL
            // Si llegamos aquí, todo salió bien. Guardamos los cambios.
            
            conn.commit();
            System.out.println("RESERVA EXITOSA!");
            System.out.println("   Asiento: " + numeroAsiento);
            System.out.println("   Estado: CONFIRMADA");
            System.out.println("   Pago: REGISTRADO");

        } catch (SQLException e) {
            // SI ALGO FALLA (Error de red, base de datos, lógica)
            try {
                if (conn != null) {
                    conn.rollback(); // DESHACER TODO (Atomicidad)
                    System.out.println(" Error en la transacción. Se ha realizado ROLLBACK.");
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            // Cerrar recursos para no dejar fugas de memoria
            try {
                if (stmtLock != null) stmtLock.close();
                if (stmtInsert != null) stmtInsert.close();
                if (stmtUpdate != null) stmtUpdate.close();
                if (stmtPago != null) stmtPago.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private static void listarReservasPorCliente() {
        Scanner sc = new Scanner(System.in);
        System.out.print("Ingrese su ID de Cliente: ");
        int id = sc.nextInt();

        String sql = "SELECT r.id_reserva, v.codigo_vuelo, a.numero_asiento, r.estado " +
                     "FROM reserva r " +
                     "JOIN vuelo v ON r.id_vuelo = v.id_vuelo " +
                     "JOIN asiento a ON r.id_asiento = a.id_asiento " +
                     "WHERE r.id_cliente = ?";

        try (Connection conn = ConexionPostgres.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            System.out.println("\n--- SUS RESERVAS ---");
            while (rs.next()) {
                System.out.println("Reserva #" + rs.getLong("id_reserva") + 
                                   " | Vuelo: " + rs.getString("codigo_vuelo") +
                                   " | Asiento: " + rs.getString("numero_asiento") +
                                   " | Estado: " + rs.getString("estado"));
            }

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}