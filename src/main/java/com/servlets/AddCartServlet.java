package com.servlets;

import java.util.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import java.util.ArrayList;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet(urlPatterns = "/add")
public class AddCartServlet extends HttpServlet{
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// get order from reader
        String order = req.getReader().readLine();
        
        // split entire query string into individual queries
        Map<String, String> orderInfo = new LinkedHashMap<String, String>();
        String[] pairs = order.split("&");
        
        // iterate through all queries, split by "=" and enter into hashmap
        for (String pair : pairs) {
        	int index = pair.indexOf("=");
        	orderInfo.put((pair.substring(0, index)), pair.substring(index + 1));
        }
        
        String product = orderInfo.get("product");
        int quantity = Integer.valueOf(orderInfo.get("qty"));

        HttpSession session = req.getSession(true);
        // if there is no existing items in the cart then create a new cart 
        if (session.getAttribute("products") == null) {
        	Map<String, Integer> cart = new LinkedHashMap<String, Integer>();
            cart.put(product, quantity);
            session.setAttribute("products", cart);
        } else {
        	Map<String, Integer> cart =  (Map)session.getAttribute("products");
            // if product is already in cart, update value
            if (cart.containsKey(product)) {
            	cart.put(product, cart.get(product) + quantity);
            }
            // otherwise add a new entry
            else {
            	cart.put(product, quantity);
            }
            
            // probably have to format it here
            session.setAttribute("products", cart);
        }

//        ArrayList<String> cartList =  (ArrayList)session.getAttribute("products");
        Map<String, Integer> currentCart =  (Map)session.getAttribute("products");
        System.out.println("Current Cart List:");
        System.out.println(currentCart);
    }
}