import java.sql.*;
import java.util.Scanner;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MenuClientes {

    public static void mostrar() {
        Scanner sc = new Scanner(System.in);
        int opcion;

        do {
            System.out.println("\n--- Gestión de Clientes ---");
            System.out.println("1. Registrar Cliente");
            System.out.println("2. Listar Clientes");
            System.out.println("3. Buscar Cliente por ID");
            System.out.println("0. Volver");
            System.out.print("Opción: ");
            opcion = sc.nextInt();

            switch (opcion) {
                case 1:
                    registrarCliente();
                    break;
                case 2:
                    listarClientes();
                    break;
                case 3:
                    buscarCliente();
                    break;
            }
        } while (opcion != 0);
    }

    private static void registrarCliente() {
        Scanner sc = new Scanner(System.in);

        System.out.print("Nombre: ");
        String nombre = sc.nextLine();

        System.out.print("Documento: ");
        String documento = sc.nextLine();

        System.out.print("Correo: ");
        String correo = sc.nextLine();

        System.out.print("Teléfono: ");
        String telefono = sc.nextLine();

        String sql = "INSERT INTO cliente (nombre, documento, correo, telefono) VALUES (?, ?, ?, ?)";

        try (Connection conn = ConexionPostgres.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nombre);
            stmt.setString(2, documento);
            stmt.setString(3, correo);
            stmt.setString(4, telefono);

            stmt.executeUpdate();
            System.out.println(" Cliente registrado correctamente.");

        } catch (SQLException e) {
            System.out.println(" Error al registrar: " + e.getMessage());
        }
    }

    private static void listarClientes() {
        String sql = "SELECT * FROM cliente";

        try (Connection conn = ConexionPostgres.conectar();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            System.out.println("\nLISTA DE CLIENTES");
            System.out.println("----------------------");

            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("id_cliente"));
                System.out.println("Nombre: " + rs.getString("nombre"));
                System.out.println("Documento: " + rs.getString("documento"));
                System.out.println("Correo: " + rs.getString("correo"));
                System.out.println("Teléfono: " + rs.getString("telefono"));
                System.out.println("--------------------");
            }

        } catch (SQLException e) {
            System.out.println(" Error: " + e.getMessage());
        }
    }

    private static void buscarCliente() {
        Scanner sc = new Scanner(System.in);
        System.out.print("Ingrese ID: ");
        int id = sc.nextInt();

        String sql = "SELECT * FROM cliente WHERE id_cliente = ?";

        try (Connection conn = ConexionPostgres.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                System.out.println("Nombre: " + rs.getString("nombre"));
                System.out.println("Documento: " + rs.getString("documento"));
                System.out.println("Correo: " + rs.getString("correo"));
                System.out.println("Teléfono: " + rs.getString("telefono"));
            } else {
                System.out.println("⚠ Cliente no encontrado.");
            }

        } catch (SQLException e) {
            System.out.println(" Error: " + e.getMessage());
        }
    }
}
