package com.servlets;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.Map;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.text.DecimalFormat;

@WebServlet(urlPatterns = "/cart")
public class DisplayCartContentsServlet extends HttpServlet {
	public void service(HttpServletRequest req, HttpServletResponse res) {
		Connection con;
	    final String JBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	    final String DB_URL = "jdbc:mysql://localhost:3306/jdbc-products";
		final DecimalFormat df = new DecimalFormat("0.00");

		try {

			String textResp = "";

			String portNum = String.valueOf(req.getServerPort());
			
			HttpSession session = req.getSession(true);

			if (session.getAttribute("products") == null) {
				textResp = "<h2>Your cart is empty!</h2>\r\n";
			} else {
				Class.forName(JBC_DRIVER);
				con = DriverManager.getConnection(DB_URL, "root", "root");
				Statement statement = con.createStatement();

				double totalPrice = 0.0;

				textResp += 
							  "     <table class=\"table\">\r\n "
							+ "       <thead>\r\n "
							+ "         <tr>\r\n "
							+ "     	   <th scope=\"col\">Item</th>\r\n "
							+ "	           <th scope=\"col\"></th>\r\n "
							+ "     	   <th scope=\"col\">Price</th>\r\n "
							+ "     	   <th scope=\"col\">Quantity</th>\r\n "
							+ "     	   <th scope=\"col\">Total</th>\r\n "
							+ "         </tr>\r\n "
							+ "     </thead>\r\n"
							+ "     <tbody>\r\n ";
				
				Map<String, Integer> cart = (Map)session.getAttribute("products");

				ArrayList<String> names = new ArrayList<String>();
				ArrayList<String> images = new ArrayList<String>();
				ArrayList<Float> prices = new ArrayList<Float>();
				ArrayList<Integer> quantities = new ArrayList<Integer>();
				ArrayList<Double> totalPrices = new ArrayList<Double>();
				
				for (Map.Entry<String, Integer> cartEntry : cart.entrySet()) {
					ResultSet resultSet = statement.executeQuery("SELECT * FROM products WHERE productName = \"" + cartEntry.getKey() + "\"");
					resultSet.next();
					String productName = resultSet.getString("productName");
					String productImgSource = "http://localhost:" + portNum + "/124Peripherals/assets/" + resultSet.getString("productImgName");
					Float productPrice = Float.parseFloat(resultSet.getString("productPrice")) * cartEntry.getValue();

					names.add(productName);
					images.add(productImgSource);
					quantities.add(cartEntry.getValue());
					prices.add(Float.parseFloat(resultSet.getString("productPrice")));
					totalPrices.add(Math.round(Double.parseDouble(productPrice.toString())* 100.0)/ 100.0);
					totalPrice += Math.round(Double.parseDouble(productPrice.toString()));
				}

				for (int i = 0; i < names.size(); i++) {
					textResp += "<tr>"
					    + "     <th scope=\"row\">" + names.get(i) + "</th>\r\n "
						+ " <td> <img src=" + images.get(i) + " class=\"card-img-top img-fluid\" alt=\"" + names.get(i) + "\" title=\"" + names.get(i) + "\" style=\"width:100px;height:100px;\" ></td>\r\n"
						+ " <td>" + prices.get(i) + "</td>"
						+ " <td>" + quantities.get(i) + "</td>"
						+ " <td>" + totalPrices.get(i) + "</td>"
						+ "</tr>";
				}

				textResp += 
						  "				</tbody>\r\n "
						+ "			</table>\r\n "
						+ "        <h1>Total Price: $" + df.format(Math.round(totalPrice * 100.00)/100.00) + " </h1> ";
			}
			
            req.setAttribute("cartInfo", textResp);
			req.getRequestDispatcher("/cart.jsp").forward(req, res);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}