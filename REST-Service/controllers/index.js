const AppError = require("../utils/appError");
const connection = require("../services/db");

exports.getAllProducts = (req, res, next) => {
    connection.query("SELECT * FROM products", function (err, data, fields) {
    if(err) return next(new AppError(err))
    res.status(200).json({
        status: "success",
        length: data?.length,
        data: data,
    });
});
};

// structure for insertions; for order submission

// exports.createTodo = (req, res, next) => {
//     if (!req.body) return next(new AppError("No form data found", 404));
//     const values = [req.body.name, "pending"];
//     conn.query(
//       "INSERT INTO todolist (name, status) VALUES(?)",
//       [values],
//       function (err, data, fields) {
//         if (err) return next(new AppError(err, 500));
//         res.status(201).json({
//           status: "success",
//           message: "todo created!",
//         });
//       }
//     );
// };

// general structure for getting individual product
exports.getProduct = (req, res, next) => {
    if (!req.params.id) {
      return next(new AppError("No product found", 404));
    }
    conn.query(
      "SELECT * FROM todolist WHERE id = ?",
      [req.params.id],
      function (err, data, fields) {
        if (err) return next(new AppError(err, 500));
        res.status(200).json({
          status: "success",
          length: data?.length,
          data: data,
        });
      }
    );
   };