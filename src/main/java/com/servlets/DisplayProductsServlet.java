package com.servlets;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

// @WebServlet(urlPatterns = {"/index", ""})
public class DisplayProductsServlet extends HttpServlet{
	// public void doGet(HttpServletRequest req, HttpServletResponse res) {
	// 	Connection con;
	//     final String JBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	//     final String DB_URL = "jdbc:mysql://localhost:3306/jdbc-products";
	    
	//     try {
    //         Class.forName(JBC_DRIVER);
    //         con = DriverManager.getConnection(DB_URL, "root", "root");

    //         Statement statement = con.createStatement();

    //         ResultSet resultSet = statement.executeQuery("SELECT * FROM products");

    //         String textResp = "";
            
    //         String portNum = String.valueOf(req.getServerPort());

    //         while (resultSet.next()) {
    //         	String productID = resultSet.getString("productID");
    //         	String productName = resultSet.getString("productName");
    //         	String productImgSource = "http://localhost:" + portNum + "/124Peripherals/assets/" + resultSet.getString("productImgName");
    //         	String productBrand = resultSet.getString("productBrand");
    //         	String productPrice = resultSet.getString("productPrice");
    //         	int productRating = Integer.valueOf(resultSet.getString("productRating"));
    //         	String productReviewNum = resultSet.getString("productReviewNum");
            	
    //         	String reviewStars = "";
    //         	int starCounter = 0;
    //         	for (int i = 0; i < 5; i++) {
    //         		if (starCounter < productRating) {
    //         			reviewStars += "<div class=\"p-0\">\r\n"
    //         					+ "         <i class=\"bi bi-star-fill\"></i>\r\n"
    //         					+ "     </div>";
    //         			starCounter += 1;
    //         		}
    //         		else {
    //         			reviewStars += "<div class=\"p-0\">\r\n"
    //         					+ "         <i class=\"bi bi-star\"></i>\r\n"
    //         					+ "     </div>";
    //         		}
    //         	}
            	
    //         	textResp += 
    //         					  "<div title="+ productName + " id=" + productName + " class=\"card border-0 hovereffect\" style=\"width: 20rem\">\r\n"
    //         			+ "            <img src=" + productImgSource + " class=\"card-img-top img-fluid\" alt=" + productName + " title=" + productName + ">\r\n"
    //         			+ "            <div class=\"card-body\">\r\n"
    //         			+ "              <p class=\"product-title fw-bold \">" + productName + "</p>\r\n"
    //         			+ "              <p class=\"product-company fw-light\">" + productBrand + "</p>\r\n"
    //         			+ "              <p class=\"product-price fw-bold\">$" + productPrice + " </p>\r\n"
    //         			+ "              <div class=\"d-flex align-items-start\">\r\n"
    //         			+ "                " + reviewStars + " \r\n"
    //         			+ "                <div class=\"p-0\">\r\n"
    //         			+ "                    <span class=\"product-reviews align-right\">&nbsp&nbsp</span>\r\n"
    //         			+ "                </div>\r\n"
    //         			+ "                <div class=\"p-0\">\r\n"
    //         			+ "                    <span class=\"product-reviews align-right\">" + productReviewNum + "  reviews</span>\r\n"
    //         			+ "                </div>\r\n"
    //         			+ "              </div>\r\n"
    //         			+ "            </div>\r\n"
    //         			+ "            <a href=\"product?productID=" + productID + " \" class=\"stretched-link\"></a>\r\n"
    //         			+ "        </div>";
    //         }

	// 		req.getRequestDispatcher("/ratings").include(req, res);
    //         req.setAttribute("products", textResp);
    //         req.getRequestDispatcher("/index.jsp").forward(req, res);

    //     } catch (Exception e) {
    //         e.printStackTrace();
    //     } 
	// }
}
