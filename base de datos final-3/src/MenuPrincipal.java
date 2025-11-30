import java.util.Scanner;

public class MenuPrincipal {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int opcion;

        do {
            System.out.println("##  SISTEMA DE RESERVAS AÉREAS|FlightBookingConcurrent  ##");
            System.out.println("1. Gestión de Clientes (y Prueba Aislamiento)");
            System.out.println("2. Gestión de Vuelos (Ver itinerarios)");
            System.out.println("3. Realizar Reserva (Transacción Segura)");
            System.out.println("4. Gestión de Pagos");
            System.out.println("0. Salir");
            System.out.print("\n>> Seleccione una opción: ");
            
            // Validación para evitar que el programa truene si meten letras
            while (!sc.hasNextInt()) {
                System.out.println("⚠ Por favor, ingrese un número válido.");
                sc.next(); 
            }
            opcion = sc.nextInt();

            switch (opcion) {
                case 1:
                    MenuClientes.mostrar();
                    break;
                case 2:
                    MenuVuelos.mostrar();
                    break;
                case 3:
                    // Asegúrate de tener creada la clase MenuReservas
                    MenuReservas.mostrar(); 
                    break;
                case 4:
                    System.out.println("\n[INFO] Módulo de Pagos en desarrollo...");
                    break;
                case 0:
                    System.out.println("\nGracias por usar el sistema. ¡Hasta pronto!");
                    break;
                default:
                    System.out.println("\n⚠ Opción no válida, intente nuevamente.");
            }

        } while (opcion != 0);

        sc.close();
    }
}