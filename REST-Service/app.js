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
    if (results && results.length > 0) {
        res.json(results);
    }
    else {
        res.status(404).send('404 Error: Product Not Found');
    }
    // res.json(results);
});

app.get('/products/:id', async function(req, res) {
    const productID = req.params.id;
    const results = await db.query("SELECT * FROM products WHERE productID = " + mysql.escape(productID));
    if (results && results.length > 0) {
        res.json(results);
    }
    else {
        console.log("AAAAAAAAAA")
        // res.status(404).send('404 Error: Product Not Found');
        // res.redirect("http://localhost:8080/error");
        res.sendStatus(404);
    }
    // res.json(results);
});

app.post('/order', (req, res) => {
    const customerInfo = req.body;
    console.log(customerInfo);
    console.log(typeof(customerInfo));

    const query = "INSERT INTO orders (orderItems, "
        + "orderTotal, "
        + "orderShippingMethod, "
        + "customerName, "
        + "customerAddress, "
        + "customerEmail, "
        + "customerPhoneNumber, "
        + "customerCardholderName, "
        + "customerCardNumber, "
        + "customerCardExpDate, "
        + "customerCardCVC, "
        + "orderMessage) VALUES "
        + "("
        + "\"" + customerInfo.orderItems + "\", "
        +        customerInfo.orderTotal + ", "
        + "\"" + customerInfo.orderShippingMethod + "\", "
        + "\"" + customerInfo.customerFirstName + " " + customerInfo.customerLastName + "\", "
        + "\"" + customerInfo.customerAddress + " " + customerInfo.customerCity + " " + customerInfo.customerState + " " + customerInfo.customerZipCode + " " + customerInfo.customerCountry + "\", "
        + "\"" + customerInfo.customerEmail + "\", "
        + "\"" + customerInfo.customerPhoneNumber + "\", "
        + "\"" + customerInfo.customerCardholderName + "\", "
        + "\"" + customerInfo.customerCardNumber + "\", "
        + "\"" + customerInfo.customerCardExpDate + "\", "
        + "\"" + customerInfo.customerCardCVC + "\", "
        + "\"" + customerInfo.orderMessage + "\""
        + ")";
    
    db.query(query);
    res.redirect("http://localhost:8080/orderDetails");
});

app.get('/recents', async function(req, res) {
    const recentOrders = await db.query("SELECT * FROM orders ORDER BY orderNumber DESC");
    if (recentOrders && recentOrders.length > 0) {
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

        res.json(Array.from(recentProducts));
    }
    else {
        res.sendStatus(404);
    }
});

app.get('/city', async function(req, res) {
    var search_query = req.query.search_query;
    var query = `
        SELECT DISTINCT city FROM zipcodes 
        WHERE city REGEXP '^${search_query}[A-Za-z]+' 
        LIMIT 10
    `;

    const results = await db.query(query);
    if (results && results.length > 0) {
        res.json(results);
    }
    else {
        res.sendStatus(404);
    }
});

app.get('/zip', async function(req, res) {
    var search_query = req.query.search_query.toString();
    var query = `
        SELECT DISTINCT zip FROM zipcodes 
        WHERE zip REGEXP '^${search_query}[0-9]+'
        LIMIT 10
    `;

    const results = await db.query(query);
    if (results && results.length > 0) {
        res.json(results);
    }
    else {
        res.sendStatus(404);
    }
});

app.get('/mostRecentOrder', async function(req, res) {
    var query = `
        SELECT orderNumber FROM orders
        ORDER BY orderNumber DESC
        LIMIT 1
    `;

    const results = await db.query(query);
    if (results && results.length > 0) {
        res.json(results);
    }
    else {
        res.sendStatus(404);
    }
});

app.post('/review', async function(req, res) {
    console.log(req.body);
    const reviewInfo = req.body;
    // console.log(`Rated product ${req.productID} with rating ${req.productRating}`);
    const productToUpdate = await db.query("SELECT * FROM products WHERE productID =" + reviewInfo.productID);

    var reviews = parseInt(productToUpdate[0].productReviewNum);
    var oldRating = parseInt(productToUpdate[0].productRating);
    var newRating = (oldRating * reviews + parseInt(reviewInfo.ratingAmount))/ (reviews + 1);

    db.query("UPDATE products SET productRating = " + newRating + " WHERE productID = " + reviewInfo.productID);
    db.query("UPDATE products SET productReviewNum = " + (reviews + 1) + " WHERE productID = " + reviewInfo.productID)

    res.redirect(303, "http://localhost:8080/");
})

app.get('*', function(req, res){
    res.send(404);
});

app.listen(port, () => console.log(`Hello world app listening on port http://localhost:3000/ !`));