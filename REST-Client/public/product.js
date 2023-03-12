function sendProduct()
{
    var product = document.getElementById("product-name").innerHTML;
    var productID = document.getElementById("productID").innerHTML;
    var qty = document.getElementById("Quantity").value;

    let cookie = document.cookie;
    if (cookie.length == 0) {
        document.cookie = productID + "=" + qty;
    } else {
        cookieObj = getObject(document.cookie);
        addProduct(cookieObj, productID, qty);
        clearCookies();
        formatCookie(cookieObj);
    }

    // console.log(document.cookie);
}

function getObject(cookie) {
    cookie = cookie.split('; ');
    let result = {};
    for (let i = 0; i < cookie.length; i++) {
        let value = cookie[i].split('=');
        result[value[0]] = value[1];
    }
    return result;
}

function formatCookie(cookieObj) {
    for (product in cookieObj) {
        document.cookie = product + "=" + cookieObj[product];
    }
}

function addProduct(cookieObject, product, qty) {
    let found = false;
    for (order in cookieObject) {
        if (order == product) {
            let numToAdd = parseInt(qty);
            let numOrder = parseInt(cookieObject[order]);
            let numNew = numToAdd + numOrder;
            cookieObject[order] = numNew;
            found = true;
        }
    }

    if (found == false) {
        cookieObject[product] = qty;
    }
    console.log(cookieObject);
}

function clearCookies() {
    const cookies = document.cookie.split(";");

    for (let i = 0; i < cookies.length; i++) {
        const cookie = cookies[i];
        const equalPos = cookie.indexOf("=");
        const name = equalPos > -1 ? cookie.substr(0, equalPos) : cookie;
        document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 UTC;path=/;";
    }
}