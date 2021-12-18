<%@page import="java.sql.*"%>
<%
    // user must be logged in middleware
    Integer userId = (Integer) session.getAttribute("id");
    if (userId == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<%
    String qid = request.getParameter("qid");
    int num = Integer.parseInt(qid);
    String dbURL = System.getenv("JDBC_DATABASE_URL");
    Connection con = null;
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(dbURL);
    PreparedStatement stat = null;
    ResultSet res = null;

    // Owner middleware
    stat = con.prepareStatement("SELECT user_id FROM questions WHERE id = ?");
    stat.setInt(1, num);
    res = stat.executeQuery();

    res.next();
    int ownerId = res.getInt(1);

    if (Integer.valueOf(userId) != ownerId) {
        response.sendRedirect("Forum.jsp");
        return;
    }

    // delete answer
    stat = con.prepareStatement("delete from questions where id= ?");
    stat.setInt(1, num);
    int i = stat.executeUpdate();

    response.sendRedirect("MyQuestions.jsp");
%>