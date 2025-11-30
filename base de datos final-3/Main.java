import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int opcion;

        do {
            System.out.println("\n===============================");
            System.out.println("   SISTEMA DE RESERVAS DE VUELOS");
            System.out.println("===============================");
            System.out.println("1. Gestión de Clientes");
            System.out.println("2. Gestión de Vuelos");
            System.out.println("3. Gestión de Reservas");
            System.out.println("4. Gestión de Pagos");
            System.out.println("0. Salir");
            System.out.print("Seleccione una opción: ");
            opcion = sc.nextInt();

            switch (opcion) {
                case 1:
                    MenuClientes.mostrar();
                    break;
                case 2:
                    MenuVuelos.mostrar();
                    break;
                case 3:
                    MenuReservas.mostrar();
                    break;
                case 4:
                    System.out.println("Módulo de pagos en construcció2n...");
                    break;
                case 0:
                    System.out.println("Saliendo del sistema...");
                    break;
                default:
                    System.out.println("Opción no válida.");
            }
        } while (opcion != 0);

        sc.close();
    }
}
