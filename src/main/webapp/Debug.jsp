<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            String dbURL = "None";
            int total = -1;
            try {
                dbURL = System.getenv("JDBC_DATABASE_URL");
                Connection con = null;
                PreparedStatement stat = null;
                ResultSet res = null;

                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection(dbURL);

                // Owner middleware
                stat = con.prepareStatement("SELECT COUNT(*) FROM users");
                res = stat.executeQuery();

                res.next();
                total = res.getInt(1);
            } catch (Exception e) {
                System.out.print(e);
                e.printStackTrace();
            }
        %>
        <p>Done jsp</p>
        <div><%= total %></div>
        <div><%= dbURL %></div>
    </body>
</html>
