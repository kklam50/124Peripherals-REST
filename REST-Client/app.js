const express = require("express");
const path = require("path");
const app = express();
var cookieParser = require('cookie-parser');

// app.use(express.static(path.join(__dirname, "services")));

app.use(express.static('public'));
app.use(cookieParser());

app.set("view engine", "ejs");

app.get("/", async function(req, res) {
    const fetchProducts = await fetch("http://localhost:3000/products")
    .then((response) => response.json())
    .then((data => results = data));

    const recentlyOrdered = await fetch("http://localhost:3000/recents")
    .then((response) => response.json())
    .then((data => recentProducts = data));
    
    res.render("index", { results, recentProducts })
 });

app.get("/product", async function (req, res) {
    const productInfo = await fetch("http://localhost:3000/products/" + req.query.productID)
    .then((response) => response.json())
    .then((data => results = data[0]));

    res.render("product", { results });
})

app.get("/orderDetails", (req, res) => {
    res.render("orderDetails");
})

app.get("/cart", async function (req, res) {
    // console.log("client-app-js line 38");
    var cart = req.cookies;
    var totalPrice = 0.00;
    var images = [];
    var names = [];
    var prices = [];
    var qtyPrices = [];
    var qty = [];
    console.log(cart);
    for (var product in cart) {
        const productQuery = await fetch("http://localhost:3000/products/" + product)
        .then((response) => response.json())
        .then((data => results = data[0]));

        names.push(productQuery.productName);
        images.push(productQuery.productImgName);
        prices.push(productQuery.productPrice);
        qty.push(cart[product]);
        qtyPrices.push(parseFloat(cart[product]) * parseFloat(productQuery.productPrice));
        totalPrice += parseFloat(productQuery.productPrice);
    }
    console.log(names[0]);
    totalPrice = totalPrice.toFixed(2);
    res.render("cart", { cart, images, qty, qtyPrices, totalPrice, names, prices });
})

app.get("/add", (req, res) => {
    res.render("cart");
})

app.post("/order", async function (req, res) {
    console.log("Test");
    res.render("orderDetails");
});


app.listen(8080, () => {
    console.log("Server started @ port 8080")
});


