<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%
    // user must be logged in middleware
    Integer userId = (Integer) session.getAttribute("id");
    if (userId == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<%
    String aid = request.getParameter("answer");
    int num = Integer.parseInt(aid);
    String qid = request.getParameter("question");
    try {
        String dbURL = System.getenv("JDBC_DATABASE_URL");
        Connection con = null;
        PreparedStatement stat = null;
        ResultSet res = null;

        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(dbURL);

        // Owner middleware
        stat = con.prepareStatement("SELECT user_id FROM answers WHERE id = ?");
        stat.setInt(1, num);
        res = stat.executeQuery();
        
        res.next();
        int ownerId = res.getInt(1);
        
        if (Integer.valueOf(userId) != ownerId) {
            response.sendRedirect("Forum.jsp");
            return;
        }
        
        // delete answer
        stat = con.prepareStatement("delete from answers where id = ?");
        stat.setInt(1, num);
        int i = stat.executeUpdate();

        response.sendRedirect("ViewAnswer.jsp?question=" + qid);
    } catch (Exception e) {
        System.out.print(e);
        e.printStackTrace();
    }
%>
