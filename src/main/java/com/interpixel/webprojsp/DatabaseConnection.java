package com.interpixel.webprojsp;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// This class can be used to initialize the database connection 
public class DatabaseConnection {

  protected static Connection initializeDatabase()
      throws SQLException, ClassNotFoundException {
    // Initialize all the information regarding
    // Database Connection
    String dbURL = System.getenv("JDBC_DATABASE_URL");
    System.out.println(dbURL);
    // Database name to access

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(dbURL);
    return con;
  }
}
