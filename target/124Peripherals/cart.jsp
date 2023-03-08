<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Asap+Condensed&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Asap+Condensed&family=Zilla+Slab:wght@300&display=swap" rel="stylesheet">

    <meta name="viewport" content="width=devicewidth,initial-scale=1">
	
	<script src="orderFormValidation.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

    <title>124 PC Peripherals</title>


</head>

<body>
    <nav class="navbar sticky navbar-expand-lg">
        <button class="navbar-toggler navbar-dark" type="button" data-toggle="collapse" data-target="#main-navbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="main-navbar">
            <ul class="nav nav-pills justify-content-center">
                <li class="nav-item">
                    <a class="nav-link" href="/124Peripherals/">124 PC Peripherals</a>
                </li>
            </ul>
        </div>
        <div class="topnav-right">
            <ul class="nav nav-pills justify-content-center">
                <li class="nav-item">
                    <a class="nav-link" href="/124Peripherals/cart.jsp">
                        <i class="bi bi-cart4"></i>
                        My Shopping Cart
                    </a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <div class="card border-0">
            <div class="container-fluid">
                <div id="page-content">
                    <div id="product-content" class="wrapper row content">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Item</th>
                                    <th scope="col"></th>
                                    <th scope="col">Price</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%@page import = "java.sql.Connection" %>
                            <%@page import = "java.sql.DriverManager" %>
                            <%@page import = "java.sql.ResultSet" %>
                            <%@page import = "java.sql.SQLException" %>
                            <%@page import = "java.sql.Statement" %>
                            <%@page import = "java.util.ArrayList" %>
                            <%@page import = "java.util.Map" %>
                            <%@page import = "java.text.DecimalFormat" %>
                            
                            <%
                            Connection con;
                            final String JBC_DRIVER = "com.mysql.cj.jdbc.Driver";
                            final String DB_URL = "jdbc:mysql://localhost:3306/jdbc-products";
                            final DecimalFormat df = new DecimalFormat("0.00");

                            Class.forName(JBC_DRIVER);
                            con = DriverManager.getConnection(DB_URL, "root", "root");
                            Statement statement = con.createStatement();


                            try {
                                String textResp = "";
                                double totalPrice = 0.0;
                                String portNum = String.valueOf(request.getServerPort());

                                if (session.getAttribute("products") == null) {
                                    textResp = "<h2>Your cart is empty!</h2>\r\n";
                                }

                                Map<String, Integer> cart = (Map)session.getAttribute("products");
                                ArrayList<String> names = new ArrayList<String>();
                                ArrayList<String> images = new ArrayList<String>();
                                ArrayList<Float> prices = new ArrayList<Float>();
                                ArrayList<Integer> quantities = new ArrayList<Integer>();
                                ArrayList<Double> totalPrices = new ArrayList<Double>();

                                if (cart != null) {
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
                                        totalPrice += Double.parseDouble(productPrice.toString());
                                    }
                                }
                                %>
                                <h1>Total Price: $ <%= df.format(Math.round(totalPrice * 100.00)/100.00) %></h1>
                                <%
                                for (int i = 0; i < names.size(); i++) {   %>
                                
                                    <tr>
                                        <th scope="row"> <%= names.get(i) %> </th>
                                        <td>
                                            <img src="<%= images.get(i) %>" class="card-img-top img-fluid" alt="<%= images.get(i) %>" title="<%= images.get(i) %>" style="width:100px;height:100px;" >
                                        </td>
                                        <td><%= prices.get(i) %></td>
                                        <td><%= quantities.get(i) %></td>
                                        <td><%= totalPrices.get(i) %></td>
                                    </tr>

                                <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            %>
                            </tbody>
                        </table>
                    </div>


                </div>

                <div class="wrapper row content">
                        <form class="row g-3" onsubmit="return validateOrder()" action="/124Peripherals/submitOrder">
                            <h1 id="OrderForm" style="text-align:left">Order Form</h1>
                            <div class="">
                                <h2>Contact Information</h2>
                            </div>
                            <div class="col-12" style="padding-bottom: 20px;">
                                <!-- <label for="Email">Email Address</label> -->
                                <input type="email" id="Email" class="form-control text-align:left" placeholder="Email Address" required>
                            </div>
                            <div class="">
                                <h2>Shipping Information</h2>
                            </div>
                            <div class="col-12" style="padding-bottom: 20px">
                                <select id="Country" class="form-select" required>
                                    <option disabled selected>Country</option>
                                    <option>United States</option>
                                </select>
                            </div>
                            <div class="col-md-6" style="padding-bottom: 20px">
                                <!-- <label for="firstName">First Name</label> -->
                                <input id="firstName" class="form-control text-align:left" placeholder="First Name" required>
                            </div>
                            <div class="col-md-6" style="padding-bottom: 20px">
                                <!-- <label for="lastName">Last Name</label> -->
                                <input id="lastName" class="form-control text-align:left" placeholder="Last Name" required>
                            </div>
                            <div class="col-12" style="padding-bottom: 20px;">
                                <!-- <label for="Address">Shipping Address</label> -->
                                <input id="Address" class="form-control text-align:left" placeholder="Shipping Address" required>
                            </div>
                            <div class="col-md-4" style="padding-bottom: 20px;">
                                <!-- <label for="City">City</label> -->
                                <input id="City" class="form-control text-align:left" placeholder="City" required>
                            </div>
                            <div class="col-md-4" style="padding-bottom: 20px;">
                                <!-- <label for="State">State</label> -->
                                <input id="State" class="form-control text-align:left" placeholder="State" required>
                            </div>
                            <div class="col-md-4" style="padding-bottom: 20px;">
                                <!-- <label for="ZipCode">Zip Code</label> -->
                                <input type="tel" id="ZipCode" class="form-control text-align:left" placeholder="Zip Code (XXXXX)" pattern="{5}" required>
                            </div>
                            <div class="col-md-6" style="padding-bottom: 20px;">
                                <!-- <label for="PhoneNumber">Phone Number</label> -->
                                <input type="tel" id="PhoneNumber" class="form-control text-align:left" placeholder="Phone Number (XXX-XXX-XXXX)" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" required>
                            </div>
                            <div class="col-md-6" style="padding-bottom: 20px;">
                                <!-- <label for="ShippingMethod">Shipping Method</label> -->
                                <select id="ShippingMethod" class="form-select" required>
                                    <option disabled selected>Shipping Method</option>
                                    <option>2 Day Expedited</option>
                                    <option>4 Day Economy</option>
                                    <option>6 Day Ground</option>
                                </select>
                            </div>
                            <div class="">
                                <h2>Payment Information</h2>
                            </div>
                            <div class="col-md-8" style="padding-bottom: 20px;">
                                <!-- <label for="CardNumber">Card Number</label> -->
                                <input type="tel" pattern="[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{4}" id="CardNumber" class="form-control text-align:left" placeholder="Card Number (XXXX XXXX XXXX XXXX)" required>
                            </div>
                            <div class="col-md-4" style="padding-bottom: 20px;">
                                <!-- <label for="CardNumber">Card Number</label> -->
                                <input id="CardholderName" class="form-control text-align:left" placeholder="Name on Card" required>
                            </div>
                            <div class="col-md-5" style="padding-bottom: 20px;">
                                <input type="tel" pattern="[0-9]{2}/[0-9]{2}" maxlength="7" id="Expiration" class="form-control text-align:left" placeholder="Expiration Date (MM/YY)" required>
                            </div>
                            <div class="col-md-6" style="padding-bottom: 20px;">
                                <!-- <label for="Expiration ">Card Number</label> -->
                                <input type="number" id="SecurityCode" class="form-control text-align:left" placeholder="Security Code" required>
                            </div>
                            <div class="col-12" style="padding-bottom: 20px;">
                                <label for="Text">Message</label>
                                <textarea id="Text" class="form-control" rows="3"></textarea>
                            </div>
                            <div class="col-12" style="padding-bottom: 20px;">
                                <button type="submit" class="btn btn-primary">Submit Order</button>
                            </div>
                        </form>
                    </div>
            </div>
        </div>
    </div>
</body>
</html>