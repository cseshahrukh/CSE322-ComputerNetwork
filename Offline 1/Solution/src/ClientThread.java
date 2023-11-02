import java.io.*;
import java.net.Socket;

public class ClientThread extends Thread {
    Socket socket; //communicates through a socket //Socket class is built in
    OutputStream out; //need to send data to server
    InputStream in; //receive data from server
    String fileName; //file that would be uploaded to server
    int chunkSize=1024;

    public ClientThread(Socket socket, String fileName) throws IOException {
        this.socket = socket;
        this.fileName = fileName;

        this.out = this.socket.getOutputStream(); //built-in in Socket Class
        this.in = this.socket.getInputStream(); //built-in in Socket Class
    }

    public void run()
    {
        PrintWriter pr = null; //PrintWriter is from java.io// To print formatted representation.

        try {
            pr = new PrintWriter(socket.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }


        //for uploading a file chunk by chunk
        try
        {
            //The fileName is that string of filename which we want to upload
            File file = new File(fileName);

            //if file exists in client's specific folder
            if(file.exists())
            {
                //Client is writing printWriter in his output of socket
                //String input = "UPLOADED " + fileName;
                pr.write("UPLOADING "+fileName);
                pr.write("\r\n");
                pr.flush();

                BufferedReader inbr = new BufferedReader(new InputStreamReader(this.in));

                String gotit = null;
                gotit = inbr.readLine();


                //Oi type er file upload kora valid kina oita
                //Server theke OK msg pathabo
                //Server er File tay implement kora ache
                if(gotit.equals("OK"))
                {
                    byte[] bufferChunk = new byte[chunkSize];
                    int count = 0;

                    BufferedInputStream bufferedInputStream = new BufferedInputStream(new FileInputStream(file));
                    //FileInputStream fis = new FileInputStream(file);

                    while((count = bufferedInputStream.read(bufferChunk)) > 0)
                    {
                        //This output will be taken from server side
                        out.write(bufferChunk, 0, count);
                        out.flush();
                    }
                    bufferedInputStream.close();
                    out.close();
                    socket.close();
                    return;
                }
                else
                {
                    System.out.println("This type of file upload is not allowed.");
                    return;
                }

            }
            else
            {
                System.out.println(fileName + " NOT FOUND");
                //String input = "NO " + fileName;
                pr.write("NO "+fileName);
                pr.write("\r\n");
                pr.flush();
                socket.close();
                return;
            }

        }catch (IOException e) {
            e.printStackTrace();
        }

    }

}