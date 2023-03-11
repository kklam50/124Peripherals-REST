const mysql = require("mysql2");
const config = require("../config");

function query(sql, params) {
    // var dbCreds = {host: 'localhost',
    //                 user: 'root',
    //                 password: 'root',
    //                 database: 'jdbc-products',
    //                 port: 3306,}
    // const connection = mysql.createConnection(dbCreds);
    const connection = mysql.createConnection(config.dbCreds);

    var results = "TEMP";

    connection.query(sql, (err, rows, fields) => {
        if (err) throw err
        results = rows;
        console.log("results: " + results);
        return results;
    })

    return results;
    // console.log("AAAAAAAAAAA");
}

module.exports = {
    query
}