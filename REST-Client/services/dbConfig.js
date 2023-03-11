const mysql = require("mysql2");
const config = require("../config");

function query(sql, params) {
    const connection = mysql.createConnection(config.dbCreds);

    return new Promise((resolve, reject) => {
        connection.query(sql, (err, rows, fields) => {
            if (err) reject (err);
            else resolve(rows);
        })
    })
}

module.exports = {
    query
}