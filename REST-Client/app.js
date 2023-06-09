const express = require("express");
const path = require("path");
const app = express();
var cookieParser = require('cookie-parser');

// app.use(express.static(path.join(__dirname, "services")));

app.use(express.static('public'));
app.use(cookieParser());

app.set("view engine", "ejs");

app.get("/", async function(req, res) {
    var statusCode = 200
    const fetchProducts = await fetch("http://localhost:3000/products")
    .then((response) => {
        statusCode = response.status
        return response.json()
    })
    .then((data => results = data));

    if (statusCode != 200) {
        res.render("error", {statusCode});
        return;
    }

    const recentlyOrdered = await fetch("http://localhost:3000/recents")
    .then((response) => response.json())
    .then((data => recentProducts = data));
    
    res.render("index", { results, recentProducts })
 });

app.get("/product", async function (req, res) {
    var statusCode = 200
    const productInfo = await fetch("http://localhost:3000/products/" + req.query.productID)

    .then((response) => {
        statusCode = response.status
        return response.json()
    })
    .then((data => results = data[0])) 

    if (statusCode != 200) {
        res.render("error", {statusCode});
        return;
    }
    res.render("product", { results });
})

app.get("/orderDetails", async function (req, res) {
    const orderInfo = await fetch("http://localhost:3000/mostRecentOrder/")
    .then((response) => response.json())
    .then((data => orderNumber = data[0].orderNumber));

    var cart = req.cookies;
    var totalPrice = 0.00;
    var images = [];
    var names = [];
    var prices = [];
    var qtyPrices = [];
    var qty = [];

    var statusCode = 200
    for (var product in cart) {
        const productQuery = await fetch("http://localhost:3000/products/" + product)
        .then((response) => {
            statusCode = response.status
            return response.json()
        })
        .then((data => results = data[0]));

        if (statusCode != 200) {
            res.render("error", {statusCode});
            return;
        }

        names.push(productQuery.productName);
        images.push(productQuery.productImgName);
        prices.push(productQuery.productPrice);
        qty.push(cart[product]);
        qtyPrices.push(parseFloat(cart[product]) * parseFloat(productQuery.productPrice));
        totalPrice += parseFloat(parseFloat(cart[product]) * parseFloat(productQuery.productPrice));
        res.clearCookie(product);
    }
    totalPrice = totalPrice.toFixed(2);
    res.render("orderDetails", { orderNumber, cart, images, qty, qtyPrices, totalPrice, names, prices });
})

app.get("/cart", async function (req, res) {
    var cart = req.cookies;
    var totalPrice = 0.00;
    var images = [];
    var names = [];
    var prices = [];
    var qtyPrices = [];
    var qty = [];
    for (var product in cart) {
        const productQuery = await fetch("http://localhost:3000/products/" + product)
        .then((response) => {
            statusCode = response.status
            return response.json()
        })
        .then((data => results = data[0]));

        if (statusCode != 200) {
            res.render("error", {statusCode});
            return;
        }

        names.push(productQuery.productName);
        images.push(productQuery.productImgName);
        prices.push(productQuery.productPrice);
        qty.push(cart[product]);
        qtyPrices.push(parseFloat(cart[product]) * parseFloat(productQuery.productPrice));
        totalPrice += parseFloat(parseFloat(cart[product]) * parseFloat(productQuery.productPrice));
    }
    totalPrice = totalPrice.toFixed(2);
    res.render("cart", { cart, images, qty, qtyPrices, totalPrice, names, prices });
})

// app.get("/add", (req, res) => {
//     res.render("cart");
// })


app.get("/error", (req, res) => {
    res.render("error");
})

app.listen(8080, () => {
    console.log("Server started @ port 8080")
});


