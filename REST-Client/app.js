const express = require("express");
const path = require("path");
const app = express();

// app.use(express.static(path.join(__dirname, "services")));
const db = require("./services/dbConfig");

app.use(express.static('public'));

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

app.get("/product", (req, res) => {
    res.render("product");
})

app.get("/orderDetails", (req, res) => {
    res.render("orderDetails");
})

app.get("/cart", (req, res) => {
    res.render("cart");
})

app.listen(8080, () => {
    console.log("Server started @ port 8080")
});


