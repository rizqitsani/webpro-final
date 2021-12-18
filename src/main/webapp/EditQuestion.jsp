<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.interpixel.webprojsp.Question"%>
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
                <div class="col-lg-6 mx-auto">
                    <div class="card my-5">
                        <div class="card-body">
                            <div class="row"> 
                                <div class="col">
                                    <h2 class="text-center my-5">Edit Question </h2>


                                    <%
                                        String dbURL = System.getenv("JDBC_DATABASE_URL");
                                        Connection con = null;
                                        ResultSet res = null;

                                        Class.forName("com.mysql.jdbc.Driver");
                                        con = DriverManager.getConnection(dbURL);
                                    %>

                                    <form action="updateQuestionServlet" method="post" class="form-group">
                                        <% String qid = request.getParameter("qid");
                                            int num = Integer.parseInt(qid);

                                            PreparedStatement stat = con.prepareStatement("select * from questions where id = ?");
                                            stat.setInt(1, num);
                                            res = stat.executeQuery();

                                            res.next();
                                            int ownerId = res.getInt(2);

                                            // Owner middleware
                                            if (Integer.valueOf(userId) != ownerId) {
                                                response.sendRedirect("Forum.jsp");
                                                return;
                                            }
                                        %>
                                        <input type="hidden" name="id" value='<%=res.getString("id")%>' />
                                        <input type="hidden" name="user_id" value='<%=res.getString("user_id")%>' />
                                        New Title<input type="text" name="title" value='<%=res.getString("title")%>' class="form-control">
                                        <br>
                                        New Description<input type="text" name="description" value='<%=res.getString("description")%>' class="form-control">
                                        <br>
                                        <input type="submit" value="Update" class="btn btn-success mb-3">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>   


    </body>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
</html>


