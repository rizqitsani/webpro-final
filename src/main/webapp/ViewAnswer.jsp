<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.interpixel.webprojsp.Answer"%>
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
        <title>View Answer</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col mx-auto">
                    <div class="card my-5">
                        <div class="card-body">
                            <div class="row"> 
                                <div class="col">
                                    <h2 class="text-center my-5">View Answer</h2>
                                    <%
                                        Integer question = Integer.valueOf(request.getParameter("question"));
                                        String dbURL = System.getenv("JDBC_DATABASE_URL");
                                        Connection con = null;
                                        PreparedStatement stat = null;
                                        ResultSet res = null;

                                        Class.forName("com.mysql.jdbc.Driver");
                                        con = DriverManager.getConnection(dbURL);

                                        stat = con.prepareStatement("select * from questions where id = ?");
                                        stat.setInt(1, question);
                                        res = stat.executeQuery();

                                        while (res.next()) {
                                    %>
                                    <a href="Forum.jsp">← Back</a>
                                    <h5 class="mt-5">Title: <p class="text-secondary"><%=res.getString("title")%></p></h5>
                                    <h5 class="mb-5">Description: <p class="text-secondary"><%=res.getString("description")%></p></h5>
                                    <a href="NewAnswer.jsp?question=<%=res.getString("id")%>" class="btn btn-primary mb-5">Add New Answer</a>
                                    <%}%>
                                    <table>
                                        <%
                                            dbURL = System.getenv("JDBC_DATABASE_URL");
                                            con = null;
                                            stat = null;
                                            res = null;

                                            Class.forName("com.mysql.jdbc.Driver");
                                            con = DriverManager.getConnection(dbURL);

                                            stat = con.prepareStatement("select answers.id,user_id,question_id,answer,name from answers INNER JOIN users ON answers.user_id = users.id WHERE question_id = ?");
                                            stat.setInt(1, question);
                                            res = stat.executeQuery();

                                            while (res.next()) {
                                        %>
                                        <tr>
                                            <td>Username: <p class="text-secondary"><%=res.getString("name")%></p></td>
                                        </tr>
                                        <tr>
                                            <td>Answer: <p class="text-secondary"><%=res.getString("answer")%></p></td>
                                        </tr>
                                        <%
                                            int uid = Integer.parseInt(res.getString("user_id"));
                                            Integer sidInt = (Integer) session.getAttribute("id");
                                            int sid = -1;
                                            if (sidInt != null) {
                                                sid = Integer.valueOf(sidInt);
                                            }
                                            System.out.println(sid);
                                            if (uid == sid) {%>
                                        <tr>
                                            <td>
                                                <a href="UpdateAnswer.jsp?answer=<%=res.getString("id")%>" class="btn btn-secondary">Update</a>
                                                <a href="DeleteAnswer.jsp?answer=<%=res.getString("id")%>&question=<%=res.getString("question_id")%>" class="btn btn-danger ml-1">Delete</a>
                                            </td>
                                        </tr>
                                        <%}%>
                                        <tr>
                                            <td> <br> </td>
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
