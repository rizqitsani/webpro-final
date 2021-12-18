package com.interpixel.webprojsp;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.regex.*;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
public class WebUtil {

  /**
   * Get the MD5 hash from a string
   *
   * @param input string to hash
   * @return hashed string
   * @author: https://www.geeksforgeeks.org/md5-hash-in-java/
   */
  public static String getMd5(String input) {
    try {

      // Static getInstance method is called with hashing MD5
      MessageDigest md = MessageDigest.getInstance("MD5");

      // digest() method is called to calculate message digest
      // of an input digest() return array of byte
      byte[] messageDigest = md.digest(input.getBytes());

      // Convert byte array into signum representation
      BigInteger no = new BigInteger(1, messageDigest);

      // Convert message digest into hex value
      String hashtext = no.toString(16);
      while (hashtext.length() < 32) {
        hashtext = "0" + hashtext;
      }
      return hashtext;
    } // For specifying wrong message digest algorithms
    catch (NoSuchAlgorithmException e) {
      throw new RuntimeException(e);
    }
  }

  /**
   * Validate the form of an email address.
   *
   * @param emailIn email to check
   * @return true if email is valid
   * @author https://blog.mailtrap.io/java-email-validation/
   */
  public static boolean isValidEmailAddress(String emailIn) {
    final String regex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
    // initialize the Pattern object
    Pattern pattern = Pattern.compile(regex);
    Matcher matcher = pattern.matcher(emailIn);
    return matcher.matches();
  }

}
