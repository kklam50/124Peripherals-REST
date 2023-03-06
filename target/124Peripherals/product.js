function sendProduct()
{
    var xmlHttp = new XMLHttpRequest();
    var theUrl = "add";
    var product = document.getElementById("product-name").innerHTML;
    var qty = document.getElementById("Quantity").value;
    xmlHttp.open("POST", theUrl, false ); // false for synchronous request
    var order = "product=" + product + "&qty=" + qty;
    xmlHttp.send(order);
    alert(product  + ", quantity: " + qty + " added to cart!");
}