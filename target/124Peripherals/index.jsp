<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Asap+Condensed&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Asap+Condensed&family=Zilla+Slab:wght@300&display=swap" rel="stylesheet">

    <meta name="viewport" content="width=devicewidth,initial-scale=1">

    <script src="index.js"></script>
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
                    <a class="nav-link" href="/124Peripherals/cart">
                        <i class="bi bi-cart4"></i>
                        My Shopping Cart
                    </a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container-fluid" style="display:block" id="Products">
    	<div class="row text-center main">
            <h2>Products</h2>
        </div>
    	
        <div class="row justify-content-center" id="product-grid">
            <%@page import = "java.sql.Connection" %>
            <%@page import = "java.sql.DriverManager" %>
            <%@page import = "java.sql.ResultSet" %>
            <%@page import = "java.sql.Statement" %>

            <%
            Connection con;
            final String JBC_DRIVER = "com.mysql.cj.jdbc.Driver";
            final String DB_URL = "jdbc:mysql://localhost:3306/jdbc-products";
            
            try {
                Class.forName(JBC_DRIVER);
                con = DriverManager.getConnection(DB_URL, "root", "root");
    
                Statement statement = con.createStatement();
    
                ResultSet resultSet = statement.executeQuery("SELECT * FROM products");
    
                String textResp = "";
                
                String portNum = "8080"; //String.valueOf(req.getServerPort());
    
                while (resultSet.next()) {
                    String productID = resultSet.getString("productID");
                    String productName = resultSet.getString("productName");
                    String productImgSource = "http://localhost:8080/124Peripherals/assets/" + resultSet.getString("productImgName");
                    String productBrand = resultSet.getString("productBrand");
                    String productPrice = resultSet.getString("productPrice");
                    int productRating = Integer.valueOf(resultSet.getString("productRating"));
                    String productReviewNum = resultSet.getString("productReviewNum");
                    
                    %> 
                    <div title= <%= productName %> id=<%= productName %> class="card border-0 hovereffect" style="width: 20rem">
                    <img src=<%= productImgSource %> class="card-img-top img-fluid" alt=<%= productName %> title=<%= productName %>>
                        <div class="card-body">
                            <p class="product-title fw-bold "><%= productName %></p>
                            <p class="product-company fw-light"><%= productBrand %></p>
                            <p class="product-price fw-bold">$<%= productPrice %> </p>
                            <div class="d-flex align-items-start">
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
                        </div>
                        <a href="product?productID= + productID %> class="stretched-link"></a>
                    </div>
                    <%
                }
    
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
    
        </div>
    </div>
    
    <div class="container-fluid" style="display:block" id="RecentOrders">
    	<div class="row text-center main">
            <h2>Rate these recent orders!</h2>
        </div>
        <div class="row justify-content-center" id="product-grid">
            ${recentOrders}
        </div>
    </div>

    <div>
        <footer class="bg-light">
            <div class="container-fluid">
                <div class = "row">
                    <div class = "col footer-info">
                        <h5 class="display-5 text-center">
                            Who we are
                        </h5>
                        <p>
                           The company was founded by Michael Dinh and Kyle Lam in 2023, and is based out of Irvine, California. We are both esports enthusiasts, who also love the gear that enables the greatest players to push the limits to what is possible.
                        </p>
                    </div>
                    <div class = "col footer-info">
                        <h5 class="display-5 text-center">
                            Our Goals
                        </h5>
                        <p>
                            124 Peripherals aims to deliver the best gaming products available on the market to gamers around the world. We source only the best mice on the market to grant gamers the greatest advantages over their opponents.
                        </p>
                    </div>
                    <div class = "col footer-info">
                        <h5 class="display-5 text-center">
                            Our Team
                        </h5>
                        <p>
                            Kyle Lam and Micahel Dinh are upcoming graduates of University California Irvine, with degrees in Software Engineering. We founded 124 Peripherals because we have a passion for getting the best of the best in gaming mice, and want to curate top of the line products for likeminded individuals.
                        </p>
                </div>
            </div>
        </footer>
    </div>


</body>

</html>
