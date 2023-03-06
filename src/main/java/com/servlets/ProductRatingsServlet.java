package com.servlets;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.Set;
import java.util.HashSet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet(urlPatterns = {"/ratings"})
public class ProductRatingsServlet extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		Connection con;
	    final String JBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	    final String DB_URL = "jdbc:mysql://localhost:3306/jdbc-products";
	    
	    try {
			// Setup the connection.
            Class.forName(JBC_DRIVER);
            con = DriverManager.getConnection(DB_URL, "root", "root");
            Statement statement = con.createStatement();

			// Get the orders in reverse order.
            ResultSet resultSet = statement.executeQuery("SELECT * FROM orders ORDER BY orderNumber DESC");
            String textResp = "";
            String portNum = String.valueOf(req.getServerPort());

			// Set up a set to store the products.
			Set<String> orderedProducts = new HashSet<String>();

			// For each order, store the products in the set.
            while (resultSet.next() && orderedProducts.size() <= 4) {
				String orderContents = resultSet.getString("orderItems");
				Pattern pattern = Pattern.compile(".(?=:)");
				Matcher matcher = pattern.matcher(orderContents);

				while(matcher.find() && orderedProducts.size() <= 4) {
					orderedProducts.add(matcher.group());
				}
			}

			int productCounter = 0;

			for (String productId : orderedProducts) {
				productCounter++;
				resultSet = statement.executeQuery("SELECT * FROM products WHERE productID=" + productId);
				resultSet.next();
				String productName = resultSet.getString("productName");
            	String productImgSource = "http://localhost:" + portNum + "/124Peripherals/assets/" + resultSet.getString("productImgName");
            	
				// Set up the star rating input, and give it an ID.
            	// Credit for star rating implementation: https://codepen.io/stoumann/pen/yLbYOdz
            	String reviewStars = "";
                reviewStars += ""
                
                +" <tr><th><label class=\"rating-label\">\r\n"
				+"   <input id=\"rating"+ productCounter + "\" \r\n"
				+"     class=\"rating rating--nojs\"\r\n"
				+"     max=\"5\"\r\n"
				+"     step=\"1\"\r\n"
				+"     type=\"range\"\r\n"
				+"     value=\"0\">\r\n"
				+"  </label></th></tr>"
				+ " <tr><th><button onclick=\"sendRating(" + productId + ", " + productCounter + ")\" id=\"sendRatingButton\" class=\"btn btn-success\">Rate</button></th></tr>";
				
            	
				// Integrate the star with the HTML response.
            	textResp +=
            					       "<div title=" + productName + " id=" + productName + " class=\"card border-0 hovereffect\" style=\"width: 20rem\">\r\n"
            			+ "            <img src=" + productImgSource + " class=\"card-img-top img-fluid\" alt=" + productName + " title=" + productName + ">\r\n"
            			+ "            <div class=\"card-body\">\r\n"
            			+ "              <p class=\"product-title fw-bold \">" + productName + "</p>\r\n"
            			+ "              <div class=\"d-flex align-items-center\">\r\n"
            			+ " 				<table>"
            			+ "                		" + reviewStars + " \r\n"
            			+ "   				</table>"
            			+ "              </div>\r\n"
            			+ "            </div>\r\n"
            			+ "        </div>";
			}

            req.setAttribute("recentOrders", textResp);

        } catch (Exception e) {
            e.printStackTrace();
        } 
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		Connection con;
	    final String JBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	    final String DB_URL = "jdbc:mysql://localhost:3306/jdbc-products";
		int productId = Integer.parseInt(req.getReader().readLine());
		int productRating = Integer.parseInt(req.getReader().readLine());

		try{
			// Setup the connection.
			Class.forName(JBC_DRIVER);
			con = DriverManager.getConnection(DB_URL, "root", "root");
			Statement statement = con.createStatement();

			// Find the product in the database.
			ResultSet resultSet = statement.executeQuery("SELECT * FROM products WHERE productID =" + productId);
			resultSet.next();
		
			// Calculate the new rating.
			int reviews = resultSet.getInt("productReviewNum");
			int oldRating = resultSet.getInt("productRating");
			int newRating = (oldRating * reviews + productRating)/ (reviews + 1);

			statement.executeUpdate("UPDATE products SET productRating = " + newRating + " WHERE productID = " + productId);
			statement.executeUpdate("UPDATE products SET productReviewNum = " + (reviews + 1) + " WHERE productID = " + productId);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
