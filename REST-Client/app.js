const express = require("express");
const path = require("path");
const app = express();

// app.use(express.static(path.join(__dirname, "services")));
const db = require("./services/dbConfig");

app.use(express.static('public'));

app.set("view engine", "ejs");

app.get("/", async function(req, res) {
    const results = await db.query("SELECT * FROM products");
    const recentOrders = await db.query("SELECT * FROM orders ORDER BY orderNumber DESC");
    let recentProducts = new Set();

    for (var i = 0; (i < recentOrders.length && recentProducts.size < 5) ; i++) {
        const regex = /(.)(?=:)/g;
        var orderContents = recentOrders[i].orderItems;
        var items = orderContents.match(regex);

        for (item of items) {
            if (recentProducts.size < 5) {
                recentProducts.add(item);
            }
        }
    }
    
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


