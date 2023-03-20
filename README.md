[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-c66648af7eb3fe8bc4f294546bfd86ef473780cde1dea487d3c4ff354943c9ae.svg)](https://classroom.github.com/online_ide?assignment_repo_id=10382841&assignment_repo_type=AssignmentRepo)

Group Members: Kyle K. Lam, Michael Dinh

General Design/Layout

Our website is an e-commerce site for selling computer gaming mice.

The index page consists of a listing of gaming mice products. Each product card includes a picture of the product, its name, its manufacturer, price, and rating. Currently, there are ten products listed on the website.

The top left "124 PC Peripherals" button redirects to the index. The top right "My Shopping Cart" button leads to a shopping cart page.

A user selects a product they are interested in, leading to a product detail page. Here, the user sees the previous information on the index about the product with some additional information. In particular, each product has a short blurb from the manufacturer and some specifications: mouse sensor, weight, and color. On this product page, the user may select a quantity of the mouse to purchase and click "Add to Cart." Upon selecting "Add to Cart," the user's browser notifies them of the successful cart addition.

From here, a user may go back to the index using the top left "124 PC Peripherals" button to browse more mice. Once the user has finished loading their cart, they select the "My Shopping Cart" button at the top right to checkout. At the Shopping Cart checkout page, the user is shown their current cart contents in a table. From here, the user may enter in their contact information and shipping information. Once the user hits Submit order, their cart is cleared and the server's backend database is updated with the user's order. The user is then redirected to an Order Details page with their order information.

Requirements:

Requirement 1:
As per Bhavaya, Express and ndoejs was allowed for this assignment. Our website instead uses Express and EJS in place of Servlets and JSP. We attempted to emulate JSP's feature of allowing Java code in the JSP file by doing the same for EJS files. 

Requirement 2:
AJAX is called when the user begins filling in the form on the cart page. Specifically, when the user begins entering in either their city or zip code, AJAX calls are made to assist the user by providing possible terms that change as the user enters in more characters.


