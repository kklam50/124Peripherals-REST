const express = require("express");
const path = require("path");
const app = express();

// app.use(express.static(path.join(__dirname, "services")));
const db = require("./services/dbConfig");

app.use(express.static('public'));

app.set("view engine", "ejs");

app.get("/", (req, res) => {
    const rows = db.query("SELECT * FROM products");
    console.log("In App:" + rows);
    // test.test();
    res.render("index")
})

app.get("/product", (req, res) => {
    res.render("product");
})

app.listen(8080, () => {
    console.log("Server started @ port 8080")
});


