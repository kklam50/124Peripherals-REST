function httpGet(theUrl)
{
    var xmlHttp = new XMLHttpRequest();
    theUrl = "/index";
    xmlHttp.open( "GET", theUrl, false ); // false for synchronous request
    xmlHttp.send( null );
    return xmlHttp.responseText;
}

// function sendRating(productID, buttonNumber)
// {
//     var xmlHttp = new XMLHttpRequest();
//     var theUrl = "http://localhost:3000/review";
//     xmlHttp.open( "POST", theUrl, false ); // false for synchronous request
//     var productRating = document.getElementById("rating" + buttonNumber).value;
//     console.log(`Product ID: ${productID}, Product Rating: ${productRating}`);
//     alert("Review submitted!");

//     var str = productID + "\n" + productRating;
    
//     xmlHttp.send(str);
    
// }