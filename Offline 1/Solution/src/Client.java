import java.io.*;
import java.net.Socket;
import java.util.Scanner;

public class Client {
    static final int PORT = 5098;

    public static void main(String[] args) throws IOException, ClassNotFoundException {

        while(true) {

            //We will open a socket from client side
            Socket socket = new Socket("localhost", PORT);
            System.out.println("Connection established as client requested");


            //If we want to upload a file from client side.
            System.out.println("Please enter a file name if you want to upload it: ");
            Scanner sc = new Scanner(System.in);
            String fileName = sc.next();


            //Multiple client at a time.
            //Clientworker extends thread. So no worries.
            Thread clientworker = new ClientThread(socket, fileName);
            clientworker.start(); //This will go to run function of ClientWorker class actually.
        }

    }
}