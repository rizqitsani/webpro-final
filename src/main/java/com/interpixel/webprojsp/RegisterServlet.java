package com.interpixel.webprojsp;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = { "/RegisterServlet" })
public class RegisterServlet extends HttpServlet {

  /**
   * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
   * methods.
   *
   * @param request  servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException      if an I/O error occurs
   */
  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    if (request.getMethod().equals("POST")) {
      if (validateInput(request, response)) {
        // if input is invalid
        response.sendRedirect("Register.jsp");
        return;
      }
      // if input is valid
      String name = request.getParameter("name");
      String email = request.getParameter("email");
      String pass = request.getParameter("pass");

      // Register the user to the database
      User.register(name, email, pass);
      response.sendRedirect("Login.jsp");
      return;
    }
    response.sendError(HttpServletResponse.SC_NOT_FOUND);
  }

  /**
   * Validate inputs
   *
   * @param request  servlet request
   * @param response servlet response
   * @return true if there exists an error
   */
  private boolean validateInput(HttpServletRequest request, HttpServletResponse response) throws IOException {
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String pass = request.getParameter("pass");
    String conPass = request.getParameter("conPass");

    HttpSession session = request.getSession();
    // Check if required input is empty
    if (name.equals("")) {
      session.setAttribute("error1", "Name required");
      return true;
    }
    if (email.equals("")) {
      session.setAttribute("error1", "Email required");
      return true;
    }
    if (pass.equals("")) {
      session.setAttribute("error1", "Password is empty!");
      return true;
    }
    if (conPass.equals("")) {
      session.setAttribute("error1", "Confirm Password is empty!");
      return true;
    }
    // Check if password and confirm password match
    if (!pass.equals(conPass)) {
      request.getSession().setAttribute("error1", "Password mismatch");
      return true;
    }
    // Check if name and length is over character limit
    if (name.length() > 254) {
      session.setAttribute("error1", "Name over 254 characters");
      return true;
    }
    if (email.length() > 254) {
      session.setAttribute("error1", "Email over 254 characters");
      return true;
    }
    // Check if email is in proper format
    if (!WebUtil.isValidEmailAddress(email)) {
      session.setAttribute("error1", "Email format invalid");
      return true;
    }
    // check if email is not registered in database
    if (!User.checkEmail(email)) {
      session.setAttribute("error1", "Email already registered");
      return true;
    }
    return false;
  }

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
  // + sign on the left to edit the code.">
  /**
   * Handles the HTTP <code>GET</code> method.
   *
   * @param request  servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException      if an I/O error occurs
   */
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    processRequest(request, response);
  }

  /**
   * Handles the HTTP <code>POST</code> method.
   *
   * @param request  servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException      if an I/O error occurs
   */
  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    processRequest(request, response);
  }

  /**
   * Returns a short description of the servlet.
   *
   * @return a String containing servlet description
   */
  @Override
  public String getServletInfo() {
    return "Short description";
  }// </editor-fold>

}
