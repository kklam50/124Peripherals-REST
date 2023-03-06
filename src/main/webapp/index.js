function httpGet(theUrl)
{
    var xmlHttp = new XMLHttpRequest();
    theUrl = "/index";
    xmlHttp.open( "GET", theUrl, false ); // false for synchronous request
    xmlHttp.send( null );
    return xmlHttp.responseText;
}

function sendRating(productID, buttonNumber)
{
    var xmlHttp = new XMLHttpRequest();
    var theUrl = "ratings";
    xmlHttp.open( "POST", theUrl, false ); // false for synchronous request
    var productRating = document.getElementById("rating" + buttonNumber).value;
    console.log(productID);
    console.log(productRating);

    var str = productID + "\n" + productRating;
    
    xmlHttp.send(str);
    
}