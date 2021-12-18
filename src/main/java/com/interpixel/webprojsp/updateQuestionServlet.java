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

@WebServlet(urlPatterns = { "/updateQuestionServlet" })
public class updateQuestionServlet extends HttpServlet {

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
        response.sendRedirect("EditQuestion.jsp");
        return;
      }

      // if input is valid
      String title = request.getParameter("title");
      String description = request.getParameter("description");
      String qid = request.getParameter("id");
      int num = Integer.parseInt(qid);

      // Register the user to the database
      Question.update(title, description, num);
      response.sendRedirect("MyQuestions.jsp");
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
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    String uid = request.getParameter("user_id");
    int num_id = Integer.parseInt(uid);

    HttpSession session = request.getSession();
    int logged_user = (Integer) session.getAttribute("id");

    if (num_id != logged_user) {
      session.setAttribute("error1", "This is not your question!");
      return true;
    }
    // Check if required input is empty
    if (title.equals("")) {
      session.setAttribute("error1", "Title required");
      return true;
    }
    if (description.equals("")) {
      session.setAttribute("error1", "Please include a description!");
      return true;
    }

    // Check if input is over character limit
    if (title.length() > 200) {
      session.setAttribute("error1", "Title over 200 characters!");
      return true;
    }
    if (description.length() > 3000) {
      session.setAttribute("error1", "Description over 3000 characters");
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
