<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Homepage</title>
        
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    </head>
    <body>
        <div class="container"> 
            <div class="row">
                <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
                    <div class="card my-5">
                        <div class="card-body">
                            <div class="row"> 
                                <div class="col">
                                    <%
                                        String uname = (String) session.getAttribute("name");
                                        if (uname != null) {
                                    %>
                                    <h1 class="text-center my-3">Hello <%= uname%>!</h1>
                                    <h5 class="text-center text-secondary mb-5">Welcome to our website.<br>Enter the forum to discuss with others.</h5>
                                    <div class="text-center mb-3"> 
                                        <a href="Forum.jsp" class="btn btn-primary">Forum</a>
                                        <a href="LogoutServlet" class="btn btn-danger">Logout</a>
                                    </div>
                                    <% } else { %>
                                    <h1 class="text-center my-5">Hello Guest!</h1>
                                    <h5 class="text-center text-secondary mb-5">Please login or register first</h5>
                                    <div class="text-center mb-3"> 
                                        <a href="Login.jsp" class="btn btn-primary">Login</a>
                                        <a href="Register.jsp" class="btn btn-link">Register</a>
                                    </div>
                                    <% } %>
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
