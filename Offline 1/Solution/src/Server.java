import java.io.File;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;


public class Server {
    //This port no should be same as server port no
    static final int PORT = 5098; //a port have to be used
    //in this assignment multiple PORT will be needed which I will implement later




    public static void main(String[] args) throws IOException {

        //ServerSocket is a built-in class. It will just make a socket with my port number.
        ServerSocket welcomeSocket = new ServerSocket(PORT);
        System.out.println("Server has started.");
        System.out.println("Listening for connections on port : "+ PORT + " ...");

        //We want to save all log history in a .txt file
        File file = new File("log.txt");


        if(file.exists()) file.delete();

        while(true) {
            //We already have opened a socket. Now this socket is ready to accept any client.
            //Socket is waiting before anyone hits the request.
            Socket socket = welcomeSocket.accept();

            // open thread
            //The ServerWorker class is my implementation. This ServerWorker extends thread.
            //The main task is in ServerWorker class.
            Thread myworker = new ServerThread(socket);
            myworker.start(); //Generate the run function of ServerWorker
        }

    }
}