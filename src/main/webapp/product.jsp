<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Asap+Condensed&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Asap+Condensed&family=Zilla+Slab:wght@300&display=swap" rel="stylesheet">

    <meta name="viewport" content="width=devicewidth,initial-scale=1">

    <script src="product.js"></script>
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
                        <%@page import = "java.sql.Connection"%>
                        <%@page import = "java.sql.DriverManager"%>
                        <%@page import = "java.sql.ResultSet"%>
                        <%@page import = "java.sql.Statement"%>
                        <%@page import = "javax.servlet.http.*"%>
                        <% 
                        Connection con;
                        final String JBC_DRIVER = "com.mysql.cj.jdbc.Driver";
                        final String DB_URL = "jdbc:mysql://localhost:3306/jdbc-products";
                        
                        try {
                            String productID = request.getParameter("productID");

                            Class.forName(JBC_DRIVER);
                            con = DriverManager.getConnection(DB_URL, "root", "root");

                            Statement statement = con.createStatement();
                            
                            ResultSet resultSet = statement.executeQuery("SELECT * FROM products WHERE productID = " + productID);
                            
                            String textResp = "";
                            
                            String portNum = "8080"; //String.valueOf(req.getServerPort());
                            
                            while (resultSet.next()) {
                                String productName = resultSet.getString("productName");
                                String productImgSource = "http://localhost:8080/124Peripherals/assets/" + resultSet.getString("productImgName");
                                String productBrand = resultSet.getString("productBrand");
                                String productPrice = resultSet.getString("productPrice");
                                int productRating = Integer.valueOf(resultSet.getString("productRating"));
                                String productReviewNum = resultSet.getString("productReviewNum");
                                String productDescription = resultSet.getString("productDescription");
                                String productSensor = resultSet.getString("productSensor");
                                String productWeight = resultSet.getString("productWeight");
                                String productColor = resultSet.getString("productColor");
                                String productMaterial = resultSet.getString("productMaterial");
                                
                                %>
                                <div id="product-images" class="col-md-6">
                                    <div class="preview">
                                        <div class="tab-pane active" id="product-pic"><img class="img-fluid" src= <%= productImgSource %> ></div>
                                    </div>
                                </div>
                                <div id="product-info" class="col-md-6">
                                    <h3 id="product-name" class="product-title fw-bold"><%= productName %></h3>
                                    <p class="product-company fw-light"><%= productBrand %></p>
                                    <div id="product-rating" class="d-flex align-items-start">
                                        <% 
                                        int starCounter = 0;
                                        for (int i = 0; i < 5; i++) {
                                            if (starCounter < productRating) {
                                                starCounter += 1;
                                                %> 
                                                <div class="p-0">
                                                    <i class="bi bi-star-fill"></i>
                                                </div> 
                                                <%
                                            }
                                            else {
                                                %> 
                                                <div class="p-0">
                                                    <i class="bi bi-star"></i>
                                                </div> 
                                                <%
                                            }
                                        }
                                        %> 
                                        <div class="p-0">
                                            <span class="product-reviews align-right">&nbsp&nbsp</span>
                                        </div>
                                        <div class="p-0">
                                            <span class="product-reviews align-right"> <%= productReviewNum %> reviews</span>
                                        </div>
                                    </div>
                                    <h4 class="d-inline product-price fw-bold">Price: </h4>
                                    <h5 class="d-inline product-price fw-bold">$<%= productPrice %> </h5>
                                    <h4 class="product-description">Product Description</h4>
                                    <p class="product-description">
                                        <%= productDescription %> 
                                    </p>
                                    <h4 class="product-description">Specs</h4>
                                    <ul class="product-description">
                                        <li class="product-description">Sensor: <%= productSensor %> </li>
                                        <li class="product-description">Weight: <%= productWeight %> </li>
                                        <li class="product-description">Color: <%= productColor %> </li>
                                        <li class="product-description">Shell Material: <%= productMaterial %> </li>
                                    </ul>
                                    <label for="Quantity">Quantity: </label>
                                        <input type="number" id="Quantity" class="col-md-1 text-align:left" min="1" max="10" value=1 required>
                                        <button onclick="sendProduct()" id="addToCartButton" class="col-md-3">Add To Cart</button>
                                </div>
                                <%
                            }
                        }
                        catch (Exception e) {
                            e.printStackTrace();
                        }
                        %>
                    </div>

                </div>
            </div>
        </div>
    </div>
    

        

</body>

</html>