package com.servlets;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.PreparedStatement;

@WebServlet(urlPatterns = "/submitOrder")
public class SubmitOrderServlet extends HttpServlet {

	private String textResp = "";
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		req.setAttribute("orderInfo", textResp);
//            req.setAttribute("orderNum", orderInfo);
		req.getRequestDispatcher("/orderDetails.jsp").forward(req, res);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
//		System.out.println("In POST");
		Connection con;
	    final String JBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	    final String DB_URL = "jdbc:mysql://localhost:3306/jdbc-products";
		final DecimalFormat df = new DecimalFormat("0.00");
		
		// get order from reader
        String order = req.getReader().readLine();
        
//        System.out.println("Order: " + order);
        
        // split entire query string into individual queries
        Map<String, String> orderInfo = new LinkedHashMap<String, String>();
        String[] pairs = order.split("&");
        
        // iterate through all queries, split by "=" and enter into hashmap
        for (String pair : pairs) {
        	int index = pair.indexOf("=");
        	orderInfo.put((pair.substring(0, index)), pair.substring(index + 1));
        }

		try {

			String portNum = String.valueOf(req.getServerPort());
			
			HttpSession session = req.getSession(true);

			if (session.getAttribute("products") == null) {
				textResp = "Your cart is empty!\r\n";
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
				
				// clear current session's cart
				session.removeAttribute("products");

				ArrayList<String> names = new ArrayList<String>();
				ArrayList<String> productIDs = new ArrayList<String>();
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
					productIDs.add(resultSet.getString("productID"));
					images.add(productImgSource);
					quantities.add(cartEntry.getValue());
					prices.add(Float.parseFloat(resultSet.getString("productPrice")));
					totalPrices.add(Math.round(Double.parseDouble(productPrice.toString())* 100.0)/ 100.0);
					totalPrice += Math.round(Double.parseDouble(productPrice.toString()));
				}
				
				String orderItems = "";

				for (int i = 0; i < names.size(); i++) {
					textResp += "<tr>"
					    + "     <th scope=\"row\">" + names.get(i) + "</th>\r\n "
						+ " <td> <img src=" + images.get(i) + " class=\"card-img-top img-fluid\" alt=\"" + names.get(i) + "\" title=\"" + names.get(i) + "\" style=\"width:100px;height:100px;\" ></td>\r\n"
						+ " <td>" + prices.get(i) + "</td>"
						+ " <td>" + quantities.get(i) + "</td>"
						+ " <td>" + totalPrices.get(i) + "</td>"
						+ "</tr>";
					
					orderItems += productIDs.get(i) + ":" + quantities.get(i) + " ";
				}

				textResp += 
						  "				</tbody>\r\n "
						+ "			</table>\r\n "
						+ "        <h1>Total Price: $" + df.format(Math.round(totalPrice * 100.00)/100.00) + " </h1> ";
				
				// create prepared statement for data insertion 
				PreparedStatement ps = con.prepareStatement("INSERT INTO orders (orderItems, "
						+ "orderTotal, "
						+ "orderShippingMethod, "
						+ "customerName, "
						+ "customerAddress, "
						+ "customerEmail, "
						+ "customerPhoneNumber, "
						+ "customerCardholderName, "
						+ "customerCardNumber, "
						+ "customerCardExpDate, "
						+ "customerCardCVC, "
						+ "orderMessage) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
				
				// populate entries for query
				ps.setString(1, orderItems);
				ps.setDouble(2, totalPrice);
				ps.setString(3, orderInfo.get("shippingMethod"));
				ps.setString(4, orderInfo.get("customerName"));
				ps.setString(5, orderInfo.get("customerAddress"));
				ps.setString(6, orderInfo.get("customerEmail"));
				ps.setString(7, orderInfo.get("customerPhoneNumber"));
				ps.setString(8, orderInfo.get("customerCardholderName"));
				ps.setString(9, orderInfo.get("customerCardNumber"));
				ps.setString(10, orderInfo.get("customerCardExpDate"));
				ps.setString(11, orderInfo.get("customerCardCVC"));
				ps.setString(12, orderInfo.get("orderMessage"));
				
				// execute query
				ps.executeUpdate();
			}
			
            req.setAttribute("orderInfo", textResp);
//            req.setAttribute("orderNum", orderInfo);
			req.getRequestDispatcher("/orderDetails.jsp").forward(req, res);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}