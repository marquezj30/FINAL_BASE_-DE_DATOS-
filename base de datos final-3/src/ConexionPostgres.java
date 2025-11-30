import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionPostgres {
    
    // 1. Mantenemos el nombre correcto de la BD y el puerto 5435
    private static final String URL = "jdbc:postgresql://localhost:5435/flight_booking_concurrent"; 
    
    // 2. CORRECCIÓN: En Mac, el usuario suele ser TU nombre de usuario del sistema
    private static final String USER = "facundosanzpalomino"; 
    
    // 3. CONTRASEÑA: En instalaciones de Mac con tu usuario, a veces NO hay contraseña.
    // Prueba primero dejándola vacía (""). Si falla, intenta con "admin".
    private static final String PASSWORD = ""; 

    public static Connection conectar() {
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            // Si ves este mensaje, ya triunfamos
            System.out.println(" Conexión exitosa a PostgreSQL");
        } catch (ClassNotFoundException e) {
             System.out.println(" Error Driver: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Error Conexión: " + e.getMessage());
            // Si el error dice "password authentication failed", cambia la variable PASSWORD arriba.
        }
        return conn;
    }

    // Un main pequeñito para probar rápido si conecta sin tener que correr todo el menú
    public static void main(String[] args) {
        conectar();
    }
}