// const express = require("express");
// const cors = require("cors");
// const router = require("./routes");
// const AppError = require("./utils/appError");
// const errorHandler = require("./utils/errorHandler");

// const app = express();

// app.use(api, router);

// app.all("*", (req, res, next) => {
//     next(new AppError(`The URL ${req.originalUrl} does not exists`, 404));
// });
// app.use(errorHandler);

// const PORT = 3000;
// app.listen(PORT, () => {
//     console.log(`server running on port ${PORT}`);
// });

// module.exports = app;

const express = require('express')
const bodyParser = require('body-parser');
const cors = require('cors');

const mysql = require("mysql2");
const db = require("./services/dbConfig");

const app = express();
const port = 3000;

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
    res.json(results);
});

app.post('/order', (req, res) => {
    const orderContents = req.body;
    console.log(orderContents);
    // res.send("Order Submitted");
    res.redirect("http://localhost:8080/orderDetails");
});

app.listen(port, () => console.log(`Hello world app listening on port http://localhost:3000/ !`));