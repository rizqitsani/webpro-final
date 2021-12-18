/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interpixel.webprojsp;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = { "/LoginServlet" })
public class LoginServlet extends HttpServlet {

  private static final long serialVersionUID = 1L;

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
      // if input is invalid
      if (validateInput(request, response)) {
        response.sendRedirect("Login.jsp");
        return;
      }
      String email = request.getParameter("email");
      String pass = request.getParameter("pass");

      // Attempt to login
      User user = User.login(email, pass);
      // Login failed
      if (user == null) {
        request.getSession().setAttribute("error1", "Email or password not found");
        response.sendRedirect("Login.jsp");
        return;
      }

      // Login successful
      HttpSession session = request.getSession();
      session.setAttribute("id", user.getId());
      session.setAttribute("name", user.getName());
      session.setAttribute("email", user.getEmail());

      response.sendRedirect("Home.jsp");
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
    String email = request.getParameter("email");
    String pass = request.getParameter("pass");
    HttpSession session = request.getSession();
    // Check if required input is empty
    if (email.equals("")) {
      session.setAttribute("error1", "Email required");
      return true;
    }
    if (pass.equals("")) {
      session.setAttribute("error1", "Password is empty!");
      return true;
    }
    // Check if name and length is over character limit
    if (email.length() > 254) {
      session.setAttribute("error1", "Email over 254 characters");
      return true;
    }
    // Check if email is in proper format
    if (!WebUtil.isValidEmailAddress(email)) {
      session.setAttribute("error1", "Email format invalid");
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
