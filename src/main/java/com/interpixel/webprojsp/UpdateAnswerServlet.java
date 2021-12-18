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

@WebServlet(urlPatterns = { "/UpdateAnswerServlet" })
public class UpdateAnswerServlet extends HttpServlet {

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
        response.sendRedirect("UpdateAnswer.jsp?answer=" + request.getParameter("answer_id"));
        return;
      }

      // if input is valid
      int answer_id = Integer.valueOf(request.getParameter("answer_id"));
      int question_id = Integer.valueOf(request.getParameter("question_id"));
      String answer = request.getParameter("answer");

      // Register the user to the database
      Answer.update(answer_id, answer);
      response.sendRedirect("ViewAnswer.jsp?question=" + question_id);
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
    String answer = request.getParameter("answer");

    HttpSession session = request.getSession();
    // Check if required input is empty
    if (answer.equals("")) {
      session.setAttribute("error1", "Answer required");
      return true;
    }

    // Check if input is over character limit
    if (answer.length() > 3000) {
      session.setAttribute("error1", "Answer over 3000 characters");
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
