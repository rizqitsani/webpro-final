<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.interpixel.webprojsp.Question"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // user must be logged in middleware
    Integer userId = (Integer) session.getAttribute("id");
    if (userId == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col mx-auto">
                    <div class="card my-5">
                        <div class="card-body">
                            <div class="row"> 
                                <div class="col">
                                    <h2 class="text-center my-5">My Questions</h2>
                                    <a href="Forum.jsp">← Back</a>
                                    <br>
                                    <br>
                                    <a href="NewQuestion.jsp" class="btn btn-primary">Add New Question</a>
                                    <br>
                                    <br>
                                    <table>
                                        <%
                                            String dbURL = System.getenv("JDBC_DATABASE_URL");
                                            Connection con = null;
                                            Statement stat = null;
                                            ResultSet res = null;

                                            Class.forName("com.mysql.jdbc.Driver");
                                            con = DriverManager.getConnection(dbURL);

                                            stat = con.createStatement();

                                            int logged_user = (Integer) session.getAttribute("id");
                                            String data = "select * from questions where user_id='" + logged_user + "'";
                                            res = stat.executeQuery(data);

                                            while (res.next()) {
                                        %>

                                        <tr>
                                            <td>Title: <p class="text-secondary"><%=res.getString("title")%></p></td>
                                        </tr>
                                        <tr>
                                            <td>Description: <p class="text-secondary"> <%=res.getString("description")%> </p></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href ='EditQuestion.jsp?qid=<%=res.getString("id")%>' class="btn btn-info"> Edit </a>
                                                <a href ='DeleteQuestion.jsp?qid=<%=res.getString("id")%>' class="btn btn-danger ml-1" > Delete </a>
                                                <a href="ViewAnswer.jsp?question=<%=res.getString("id")%>" class="btn btn-success ml-1">View Answers</a>
                                            </td> 
                                        </tr>
                                        <%}%>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
    </body>
</html>
