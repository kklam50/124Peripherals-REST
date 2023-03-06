package com.servlets;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(urlPatterns = "/product")
public class DisplayProductPageServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		Connection con;
	    final String JBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	    final String DB_URL = "jdbc:mysql://localhost:3306/jdbc-products";
		
		try {
			String productID = req.getParameter("productID");

			Class.forName(JBC_DRIVER);
            con = DriverManager.getConnection(DB_URL, "root", "root");

            Statement statement = con.createStatement();
            
            ResultSet resultSet = statement.executeQuery("SELECT * FROM products WHERE productID = " + productID);
            
            String textResp = "";
            
            String portNum = String.valueOf(req.getServerPort());
            
            while (resultSet.next()) {
            	String productName = resultSet.getString("productName");
            	String productImgSource = "http://localhost:" + portNum + "/124Peripherals/assets/" + resultSet.getString("productImgName");
            	String productBrand = resultSet.getString("productBrand");
            	String productPrice = resultSet.getString("productPrice");
            	int productRating = Integer.valueOf(resultSet.getString("productRating"));
            	String productReviewNum = resultSet.getString("productReviewNum");
            	String productDescription = resultSet.getString("productDescription");
            	String productSensor = resultSet.getString("productSensor");
            	String productWeight = resultSet.getString("productWeight");
            	String productColor = resultSet.getString("productColor");
            	String productMaterial = resultSet.getString("productMaterial");
            	
            	String reviewStars = "";
            	int starCounter = 0;
            	for (int i = 0; i < 5; i++) {
            		if (starCounter < productRating) {
            			reviewStars += "<div class=\"p-0\">\r\n"
            					+ "         <i class=\"bi bi-star-fill\"></i>\r\n"
            					+ "     </div>";
            			starCounter += 1;
            		}
            		else {
            			reviewStars += "<div class=\"p-0\">\r\n"
            					+ "         <i class=\"bi bi-star\"></i>\r\n"
            					+ "     </div>";
            		}
            	}
            	
            	textResp += "<div id=\"product-images\" class=\"col-md-6\">\r\n"
            			+ "        <div class=\"preview\">\r\n"
            			+ "            <div class=\"tab-pane active\" id=\"product-pic\"><img class=\"img-fluid\" src=" + productImgSource + " ></div>\r\n"
            			+ "        </div>\r\n"
            			+ "    </div>\r\n"
            			+ "    <div id=\"product-info\" class=\"col-md-6\">\r\n"
            			+ "        <h3 id=\"product-name\" class=\"product-title fw-bold\">" + productName + "</h3>\r\n"
            			+ "        <p class=\"product-company fw-light\">" + productBrand + " </p>\r\n"
            			+ "        <div id=\"product-rating\" class=\"d-flex align-items-start\">\r\n"
            			+ "            " + reviewStars + " \r\n"
            			+ "            <div class=\"p-0\">\r\n"
            			+ "                <span class=\"product-reviews align-right\">&nbsp&nbsp</span>\r\n"
            			+ "            </div>\r\n"
            			+ "            <div class=\"p-0\">\r\n"
            			+ "                <span class=\"product-reviews align-right\">" + productReviewNum + "  reviews</span>\r\n"
            			+ "            </div>\r\n"
            			+ "        </div>\r\n"
            			+ "        <h4 class=\"d-inline product-price fw-bold\">Price: </h4>\r\n"
            			+ "        <h5 class=\"d-inline product-price fw-bold\">$" + productPrice + " </h5>\r\n"
            			+ "        <h4 class=\"product-description\">Product Description</h4>\r\n"
            			+ "        <p class=\"product-description\">\r\n"
            			+ "            " + productDescription + " \r\n"
            			+ "        </p>\r\n"
            			+ "        <h4 class=\"product-description\">Specs</h4>\r\n"
            			+ "        <ul class=\"product-description\">\r\n"
            			+ "            <li class=\"product-description\">Sensor: " + productSensor + " </li>\r\n"
            			+ "            <li class=\"product-description\">Weight: " + productWeight + " </li>\r\n"
            			+ "            <li class=\"product-description\">Color: " + productColor + " </li>\r\n"
            			+ "            <li class=\"product-description\">Shell Material: " + productMaterial + " </li>\r\n"
            			+ "        </ul>\r\n"
            			+ "		   <label for=\"Quantity\">Quantity: </label>"
            			+ "		   <input type=\"number\" id=\"Quantity\" class=\"col-md-1 text-align:left\" min=\"1\" max=\"10\" value=1 required>"
            			+ "		   <button onclick=\"sendProduct()\" id=\"addToCartButton\" class=\"col-md-3\">Add To Cart</button>"
            			+ "    </div>";
            }
            req.setAttribute("productInfo", textResp);
			req.getRequestDispatcher("/product.jsp").forward(req, res);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}