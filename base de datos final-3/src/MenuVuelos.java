import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Scanner;

public class MenuVuelos {

    public static void mostrar() {
        Scanner sc = new Scanner(System.in);
        int opcion;

        do {
            System.out.println("\n--- GESTIÓN DE VUELOS ---");
            System.out.println("1. Listar Itinerarios (Vuelos Disponibles)");
            System.out.println("2. Buscar vuelo por Código (Ej: LAT550)");
            System.out.println("0. Volver");
            System.out.print("Opción: ");
            
            opcion = sc.nextInt();
            sc.nextLine(); // Limpiar buffer

            switch (opcion) {
                case 1:
                    listarVuelos();
                    break;
                case 2:
                    buscarVuelo();
                    break;
            }
        } while (opcion != 0);
    }

    private static void listarVuelos() {
        // CONSULTA AVANZADA: Usamos JOIN para mostrar nombres de ciudades en vez de IDs aburridos
        String sql = "SELECT v.id_vuelo, v.codigo_vuelo, v.fecha_salida, v.fecha_llegada, v.estado, " +
                     "a1.ciudad AS origen, a1.codigo_iata AS iata_origen, " +
                     "a2.ciudad AS destino, a2.codigo_iata AS iata_destino, " +
                     "av.modelo AS avion " +
                     "FROM vuelo v " +
                     "JOIN aeropuerto a1 ON v.id_aeropuerto_origen = a1.id_aeropuerto " +
                     "JOIN aeropuerto a2 ON v.id_aeropuerto_destino = a2.id_aeropuerto " +
                     "JOIN avion av ON v.id_avion = av.id_avion " +
                     "ORDER BY v.fecha_salida";

        // Formato de fecha amigable
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");

        try (Connection conn = ConexionPostgres.conectar();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            System.out.println("\nITINERARIOS DISPONIBLES");
            System.out.println("----------------------------------------------------------------------------------------");
            // Formato de tabla: %-5s significa "string de 5 espacios alineado a la izquierda"
            System.out.printf("%-5s | %-8s | %-20s | %-20s | %-15s | %-10s%n", 
                              "ID", "CODIGO", "ORIGEN", "DESTINO", "AVION", "SALIDA");
            System.out.println("----------------------------------------------------------------------------------------");

            while (rs.next()) {
                String rutaOrigen = rs.getString("origen") + " (" + rs.getString("iata_origen") + ")";
                String rutaDestino = rs.getString("destino") + " (" + rs.getString("iata_destino") + ")";
                String salida = sdf.format(rs.getTimestamp("fecha_salida"));

                System.out.printf("%-5d | %-8s | %-20s | %-20s | %-15s | %-10s%n",
                        rs.getLong("id_vuelo"), // OJO: Usamos getLong por ser BIGINT
                        rs.getString("codigo_vuelo"),
                        rutaOrigen,
                        rutaDestino,
                        rs.getString("avion"),
                        salida);
            }
            System.out.println("----------------------------------------------------------------------------------------");

        } catch (SQLException e) {
            System.out.println("❌ Error al listar vuelos: " + e.getMessage());
        }
    }

    private static void buscarVuelo() {
        Scanner sc = new Scanner(System.in);
        System.out.print("Ingrese Código del vuelo (Ej: LA2400): ");
        String codigo = sc.nextLine();

        // Misma lógica de JOIN para la búsqueda individual
        String sql = "SELECT v.id_vuelo, v.codigo_vuelo, v.fecha_salida, v.fecha_llegada, v.estado, " +
                     "a1.ciudad AS origen, a1.pais AS pais_origen, " +
                     "a2.ciudad AS destino, a2.pais AS pais_destino " +
                     "FROM vuelo v " +
                     "JOIN aeropuerto a1 ON v.id_aeropuerto_origen = a1.id_aeropuerto " +
                     "JOIN aeropuerto a2 ON v.id_aeropuerto_destino = a2.id_aeropuerto " +
                     "WHERE v.codigo_vuelo = ?";

        try (Connection conn = ConexionPostgres.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, codigo);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                System.out.println("\n>>> DETALLE DE VUELO ENCONTRADO <<<");
                System.out.println("ID Interno:   " + rs.getLong("id_vuelo"));
                System.out.println("Código:       " + rs.getString("codigo_vuelo"));
                System.out.println("Origen:       " + rs.getString("origen") + ", " + rs.getString("pais_origen"));
                System.out.println("Destino:      " + rs.getString("destino") + ", " + rs.getString("pais_destino"));
                System.out.println("Salida:       " + rs.getTimestamp("fecha_salida"));
                System.out.println("Llegada:      " + rs.getTimestamp("fecha_llegada"));
                System.out.println("Estado:       " + rs.getString("estado"));
            } else {
                System.out.println("⚠ Vuelo no encontrado con ese código.");
            }

        } catch (SQLException e) {
            System.out.println(" Error en búsqueda: " + e.getMessage());
        }
    }
}