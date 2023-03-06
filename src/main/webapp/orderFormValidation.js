function validateOrder() {
  var msg = "";

  var email = document.getElementById("Email").value;
  msg += "customerEmail=" + email;

  let destinationCountry = document.getElementById("Country").value;
  if (destinationCountry === "Country") {
    alert("Please select a Destination Country.");
    return false;
  }

  let firstName = document.getElementById("firstName").value;
  let lastName = document.getElementById("lastName").value;
  msg += "&customerName=" + firstName + " " + lastName;

  let destinationAddress = document.getElementById("Address").value;
  msg += "&customerAddress=" + destinationAddress;

  let destinationCity = document.getElementById("City").value;
  // msg += "destinationCity=" + destinationCity;
  msg += " " + destinationCity;

  let destinationState = document.getElementById("State").value;
  // msg += "State=" + destinationState;
  msg += ", " + destinationState;

  let destinationZipCode = document.getElementById("ZipCode").value;
  // msg += "Zip Code=" + destinationZipCode;
  msg += " " + destinationZipCode + " " + destinationCountry;

  let phoneNumber = document.getElementById("PhoneNumber").value;
  msg += "&customerPhoneNumber=" + phoneNumber;

  let shippingMethod = document.getElementById("ShippingMethod").value;
  msg += "&shippingMethod=" + shippingMethod;

  let cardNumber = document.getElementById("CardNumber").value;
  msg += "&customerCardNumber=" + cardNumber;

  let cardholderName = document.getElementById("CardholderName").value;
  msg += "&customerCardholderName=" + cardholderName;

  let cardExpiration = document.getElementById("Expiration").value;
  msg += "&customerCardExpDate=" + cardExpiration;

  let cardSecurityCode = document.getElementById("SecurityCode").value;
  msg += "&customerCardCVC=" + cardSecurityCode;

  let message = document.getElementById("Text").value;
  msg += "&orderMessage=" + message;

  var xmlHttp = new XMLHttpRequest();
  var theUrl = "submitOrder";
  xmlHttp.open("POST", theUrl, false ); // false for synchronous request

  xmlHttp.send(msg);
}