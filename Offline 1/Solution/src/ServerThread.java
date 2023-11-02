/*
Author: Md. Shahrukh Islam
CSE, BUET
Roll: 1805098
 */

import java.io.*;
import java.net.Socket;
import java.nio.file.Files;
import java.util.Date;


public class ServerThread extends Thread {

    OutputStream out; //To give output of the socket
    InputStream in; //To take input in the socket
    Socket socket;
    int chunkSize=1024;

    //We have to generate a log file; This printwriter will print in my logfile
    PrintWriter myWriter = new PrintWriter(new FileWriter("log.txt", true));



    public ServerThread(Socket socket) throws IOException {
        this.socket = socket;
        this.out = this.socket.getOutputStream(); //built-in function of socket
        this.in = this.socket.getInputStream(); //built-in function of socket
    }




    public void run()
    {


        //Just converting input of the socket in BufferReader
        BufferedReader inbr = new BufferedReader(new InputStreamReader(this.in));

        //For output of socket
        PrintWriter pr = null;


        try {
            pr = new PrintWriter(socket.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }


        try {
            //Converting BufferReader into a string. This is actually input bufferReader
            String input = inbr.readLine();

            if(input==null)
            {
                System.out.println("Input is Null. This should never be printed");
            }
            else if(input != null)
            {
                //myWriter is for logfile writer
                myWriter.println("HTTP request : " + input);
                myWriter.println("HTTP response : ");
                StringBuilder sb = new StringBuilder();


                myWriter.append("");

                //GET, UPLOADING, NO
                //      GET / HTTP/1.1
                if(input.startsWith("GET"))
                {
                    String startContent = "<html> \n";

                    String middleContent = "";

                    //sb is a stringBuilder
                    //If we pass this string as output of the socket then that web page will be shown
                    sb.append(startContent);
                    sb.append( "<head> \n");
                    sb.append( "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"> \n");
                    sb.append( "<link rel=\"icon\" href=\"data:,\">\n" );
                    sb.append( "</head> \n<body> \n" );
                    //sb.append( "<body> \n" );


                    //This input == Output of client's socket
                    String[] splitStr = input.split(" ");

                    String tempFile = splitStr[1].substring(1);

                    //Ignoring the slash
                    File fileCheck = new File(tempFile);

 

                    //both functions are built-in function
                    //Handling the File Download Option, only download
                    if(fileCheck.exists() && fileCheck.isFile())
                    {

                        if (tempFile.endsWith("jpg") || tempFile.endsWith("png") ||
                                tempFile.endsWith("jpeg") || tempFile.endsWith("txt")) {

                            byte[] bufferChunk = new byte[chunkSize];
                            int count;

                            BufferedInputStream bis = new BufferedInputStream(new FileInputStream(fileCheck));

                            OutputStream socket_out = socket.getOutputStream();

                            //if a image file
                            pr.write("HTTP/1.1 200 OK\r\n");
                            pr.write("Server: Java HTTP Server: 1.0\r\n");
                            pr.write("Date: " + new Date() + "\r\n");

                            String MIME_type = Files.probeContentType(fileCheck.toPath());

                            pr.write("Content-Type: "+MIME_type+"\r\n");
                            pr.write("Content-Length: " + fileCheck.length() + "\r\n");
                            pr.write("\r\n");
                            pr.flush();
                            // pr.write(content);


                            //writing response to log file
                            myWriter.println("HTTP Response");
                            myWriter.println("--------------");
                            myWriter.write("HTTP/1.1 200 OK\r\n");
                            myWriter.write("Server: Java HTTP Server: 1.0\r\n");
                            myWriter.write("Date: " + new Date() + "\r\n");
                            myWriter.write("Content-Type: "+MIME_type+"\r\n");
                            myWriter.write("Content-Length: " + fileCheck.length() + "\r\n");
                            myWriter.write("\r\n");
                            myWriter.write("Content: "+fileCheck.getAbsolutePath()+"\n");
                            myWriter.println();
                            myWriter.println();




                            while((count = bis.read(bufferChunk)) > 0)
                            {
                                socket_out.write(bufferChunk, 0, count);
                                socket_out.flush();
                            }

                        }



                        else //for other files,file will be download
                        {
                            //Writing in socket output
                            pr.write("HTTP/1.1 200 OK\r\n");
                            pr.write("Server: Java HTTP Server: 1.0\r\n");
                            pr.write("Date: " + new Date() + "\r\n");
                            pr.write("Content-type: application/x-force-download" + "\r\n");
                            pr.write("Content-Length: " + fileCheck.length() + "\r\n");
                            pr.write("\r\n");
                            pr.flush();


                            //Writing in log file
                            myWriter.println("HTTP/1.1 200 OK\n");
                            myWriter.println("Server: Java HTTP Server: 1.0\r\n");
                            myWriter.println("Date: " + new Date() + "\r\n");
                            //String probeContentType = Files.probeContentType(fileCheck.toPath());
                            myWriter.println("Content-type: " + Files.probeContentType(fileCheck.toPath()) + "\r\n");;
                            myWriter.println("Content-Length: " + fileCheck.length() + "\r\n");
                            myWriter.println("\r\n");


                            byte[] bufferChunk = new byte[chunkSize];
                            int count;
                            BufferedInputStream newInput = new BufferedInputStream(new FileInputStream(fileCheck));
                            while((count = newInput.read(bufferChunk)) > 0)
                            {
                                out.write(bufferChunk, 0, count);
                                out.flush();
                            }

                        }
                        /*

                        */

                    }

                    //If it's a directory
                    else if(splitStr[1].equals("/") || (fileCheck.exists() && fileCheck.isDirectory()))
                    {
                        //Emni null kore rakhlam
                        File file=new File("");
                        if(splitStr[1].equals("/"))
                        {
                            file = new File("root");
                        }
                        else
                        {

                            String directory = splitStr[1].substring(1); //After the slash
                            file = new File(directory);

                        }

                        //Oi directory te jotogula file ache oder list rakhtechi
                        File[] fileList = file.listFiles();

                        //Making an unordered list in html
                        middleContent = middleContent + "<ul>\n";

                        if (fileList==null)
                        {
                            System.out.println("The list is null. That means the directory is empty.");
                        }
                        else {
                            for (File value : fileList) {
                                if (value.exists()) {
                                    File parent = value.getParentFile();
                                    String dirLink = parent.getName() + "/" + value.getName();
                                    middleContent = middleContent + "<li> ";

                                    if (value.isDirectory()) {
                                        middleContent = middleContent + "<a style=\"font-weight:bold\" href = " + dirLink + "> " + value.getName() + " </a>";
                                    } else if (value.isFile()) {
                                        middleContent = middleContent + "<a href = " + dirLink + "> " + value.getName() + " </a>";
                                    }

                                    middleContent = middleContent + " </li>\n";
                                } else {
                                    System.out.println("Corrupted File\n");

                                }
                            }
                            middleContent = middleContent + "</ul>\n";
                            sb.append( middleContent );

                            String endcontent = "</body> \n";
                            sb.append( endcontent );
                            sb.append( "</html>\n\n" );

                            String content = sb.toString();
                            //System.out.println(content);

                            pr.write("HTTP/1.1 200 OK\r\n");
                            pr.write("Server: Java HTTP Server: 1.0\r\n");
                            pr.write("Date: " + new Date() + "\r\n");
                            pr.write("Content-Type: text/html\r\n");
                            pr.write("Content-Length: " + content.length() + "\r\n");
                            pr.write("\r\n");
                            pr.write(content);
                            pr.flush();



                            myWriter.println("HTTP/1.1 200 OK\r\n");
                            myWriter.println("Server: Java HTTP Server: 1.0\r\n");
                            myWriter.println("Date: " + new Date() + "\r\n");
                            myWriter.println("Content-Type: text/html\r\n");
                            myWriter.println("Content-Length: " + content.length() + "\r\n");
                            myWriter.println("\r\n");

                            //We won't print the content in the log file
                            //myWriter.println(content);


                        }
                    }

                    //404 Not Found
                    else
                    {

                        //middleContent = "" + "<h2> 404: Page not found</h2>\n";
                        sb.append("<h2> 404: Page not found</h2>\n");

                        //String endContent = "</body> \n";
                        sb.append( "</body> \n" );
                        sb.append( "</html>\n\n" );

                        String content = sb.toString();

                        System.out.println("HTTP/1.1 404 NOT FOUND\n");
                        pr.write("HTTP/1.1 404 NOT FOUND\r\n");
                        pr.write("Server: Java HTTP Server: 1.0\r\n");
                        pr.write("Date: " + new Date() + "\r\n");
                        pr.write("\r\n");
                        pr.write(content);
                        pr.flush();


                        myWriter.println("HTTP/1.1 404 NOT FOUND\r\n");
                        myWriter.println("Server: Java HTTP Server: 1.0\r\n");
                        myWriter.println("Date: " + new Date() + "\r\n");
                        myWriter.println("\r\n");
                        //myWriter.println(content);


                    }


                    myWriter.flush();
                    myWriter.close();
                    socket.close();
                }

                //When client wants to upload a specific file
                else if(input.startsWith("UPLOADING"))
                {

                    String[] splitStr = input.split(" ");
                    String fileName = splitStr[1];

                    if(fileName.endsWith("txt")||fileName.contains("jpg")||fileName.contains("png")||
                    fileName.endsWith("mp4"))
                    {
                        //pr is output of socket
                        pr.write("OK");
                        pr.write("\r\n");
                        pr.flush();



                        String workingDir = System.getProperty("user.dir");
                        //String absoluteFilePath = workingDir + "/root/" + fileName;
                        //String absoluteFilePath = workingDir + "/root/uploaded_files/" + fileName;
                        String absoluteFilePath = workingDir + "/uploaded_files/" + fileName;
                        File file = new File(absoluteFilePath);


                        byte[] bufferChunk = new byte[chunkSize];
                        int count;


                        FileOutputStream fileOutputStream = new FileOutputStream(file);

                        while((count = in.read(bufferChunk)) > 0)
                        {
                            fileOutputStream.write(bufferChunk, 0, count);
                            fileOutputStream.flush();
                        }

                        fileOutputStream.close();
                        in.close();
                        socket.close();
                    }
                    else
                    {
                        pr.write("NO");
                        pr.write("\r\n");
                        pr.flush();
                        in.close();
                        socket.close();
                    }


                }

                //Oi file pawa na gele ami NO likhe diyechilam
                else if(input.startsWith("NO"))
                {
                    String[] splitStr = input.split(" ");
                    //String fileName = splitStr[1];
                    System.out.println(splitStr[1] + " NOT FOUND");
                    socket.close();
                }

            }

        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}