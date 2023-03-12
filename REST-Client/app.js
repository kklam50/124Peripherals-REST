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

app.get("/cart", (req, res) => {
    console.log("client-app-js line 38");
    console.log(req.cookies);
    var cart = req.cookies;
    res.render("cart", { cart });
})

app.get("/add", (req, res) => {
    res.render("cart");
})


app.listen(8080, () => {
    console.log("Server started @ port 8080")
});


