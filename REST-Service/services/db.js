const mysql = require("mysql2");
const dbCreds = {
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'jdbc-products',
    port: 3306,
};
const connection = mysql.createConnection(dbCreds);

connection.connect();

module.exports = connection;