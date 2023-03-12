const express = require('express')
const bodyParser = require('body-parser');
const cors = require('cors');

const mysql = require("mysql2");
const db = require("./services/dbConfig");

const app = express();
const port = 3000;

const CookieParser = require('cookie-parser');
app.use(CookieParser());

app.use(cors());

// Configuring body parser middleware
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get('/products', async function(req, res) {
    const results = await db.query("SELECT * FROM products");
    res.json(results);
});

app.get('/products/:id', async function(req, res) {
    const productID = req.params.id;
    const results = await db.query("SELECT * FROM products WHERE productID = " + mysql.escape(productID));
    console.log("Product clicked: " + productID);
    res.json(results);
});

app.get('/order', (req, res) => {
    const orderContents = req.cookies.products;
    console.log("Order Contents: " + orderContents);
});


app.post('/order', (req, res) => {
    const customerInfo = req.body;
    console.log(customerInfo);
    const orderContents = req.cookies.products;
    console.log("Order Contents: " + orderContents);
    // res.send("Order Submitted");
    res.redirect("http://localhost:8080/orderDetails");
});

app.get('/recents', async function(req, res) {
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

    console.log(Array.from(recentProducts));

    res.json(Array.from(recentProducts));
});

app.get('/city', async function(req, res) {
    var search_query = req.query.search_query;
    var query = `
        SELECT DISTINCT city FROM zipcodes 
        WHERE city REGEXP '^${search_query}[A-Za-z]+' 
        LIMIT 10
    `;

    const results = await db.query(query);
    // console.log(results);
    res.json(results);
});

app.get('/zip', async function(req, res) {
    var search_query = req.query.search_query.toString();
    var query = `
        SELECT DISTINCT zip FROM zipcodes 
        WHERE zip REGEXP '^${search_query}[0-9]+'
        LIMIT 10
    `;

    const results = await db.query(query);
    // console.log(results);
    res.json(results);
});

app.listen(port, () => console.log(`Hello world app listening on port http://localhost:3000/ !`));