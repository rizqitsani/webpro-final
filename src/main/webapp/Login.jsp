<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    </head>
    <body>
        <div class="container"> 
            <div class="row">
                <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
                    <div class="card my-5">
                        <h2 class="card-title text-center my-3">Login</h2>
                        <div class="card-body">
                            <div class="row"> 
                                <div class="col">
                                    <a href="Home.jsp" class="mb-3">← Back</a>
                                    <%
                                        // if user is logged in, redirect to home page
                                        Integer userId = (Integer) session.getAttribute("id");
                                        if (userId != null) {
                                            response.sendRedirect("Home.jsp");
                                            return;
                                        }
                                    %>

                                    <%
                                        // show errors if any exist
                                        String errMsg = (String) session.getAttribute("error1");
                                        if (errMsg != null) {
                                    %>
                                    <div style ="color:red;"> <%= errMsg%> </div>
                                    <%
                                            session.removeAttribute("error1");
                                        }
                                    %>
                                    <form class="mt-3" action="LoginServlet" method="POST">
                                        <div class="form-group">
                                            <label for="imputEmail">Email</label>
                                            <input type="email" name="email" class="form-control" id="inputEmail" placeholder="Enter Email">
                                        </div>
                                        <div class="form-group">
                                            <label for="inputPassword">Password</label>
                                            <input type="password" name="pass" class="form-control" id="inputPassword" placeholder="Password">
                                        </div>
                                        <input type="submit" class="btn btn-primary mb-3" value="Login">
                                    </form>
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
