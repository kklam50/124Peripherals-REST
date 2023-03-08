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

    <div class="container">
        <div class="card border-0">
            <div class="container-fluid">
                <div id="page-content">
                	<h1>Thank you for your order!</h1>
                    <h2>Order Summary:</h2>
                    ${orderNum}
			        <div class="row justify-content-center" id="product-grid">
			            ${orderInfo}
			        </div>
			        
                </div>
            </div>
        </div>
    </div>


</body>

</html>