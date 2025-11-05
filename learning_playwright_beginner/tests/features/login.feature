Feature: user login functionality
"""
in this file we will test the user login functionality of the application
"""
Scenario Outline: login with valid credentials
Given  the user on the login page
When user enters <username> and <password>
And clicks on the login button
Then user should be logged in successfully

Examples:
| username     | password   |
| testuser1        | 1234pass1      |       
| testuser2        | 5678pass2      |

Scenario: login with invalid credentials
Given the user on the login page
When user enters invalid credentials
Then user shouldn't be logged in successfully

Examples:
username    password
testusers   12345678
testuserv   12378945

Scenario: login with empty credentials
Given the user on the login page
When user didn't enters credentials
Then user shouldn't be logged in successfully 
And  application shows error message

Examples:
username    password

Feature: Search functionality
Scenario:Search for a product
Given user is on the home page
When user enters "laptop" in the search bar
And clicks on the search button
Then search results for "laptop" should be displayed


Scenario: Search with no results
Given user is on the home page
When user search with no results
Then user shouldn't see any results
Examples:
| searchTerm    |                                                                       
| asdfghjklqwertyuiop |



Scenario: Search with empty input
Given user is on the home page
When user leaves the search bar empty
Then user shouldn't see any results         

Examples:
| searchTerm |                                                                          

Scenario:add item to cart
Given user is on the product page
When user selects a product and clicks on "Add to Cart" button
Then the product should be added to the cart successfully
Examples:
| productName      |    
| Laptop Model A   |
| Smartphone Model B|
Scenario: add out of stock item to cart
Given user is on the product page
When user selects an out of stock product and clicks on "Add to Cart" button
Then the product shouldn't be added to the cart                                                 
Examples:
| productName        |
| Headphones Model C |
Scenario: add item to cart without selecting options
Given user is on the product page
When user tries to add a product to the cart without selecting required options
Then the product shouldn't be added to the cart 
Examples:
| productName      |
| Laptop Model D   |                

Scenario: remove item from cart
Given user has items in the cart
When user views the cart and clicks on "Remove" button for a specific item
Then the item should be removed from the cart successfully  
Examples:
| productName      |        
| Laptop Model A   |
| Smartphone Model B|
Scenario: remove item from cart when cart is empty
Given user has an empty cart
When user tries to remove an item from the cart
Then user shouldn't be able to remove any items
Examples:
| productName      |
| Laptop Model E   |
Scenario: remove item from cart with invalid item
Given user has items in the cart
When user tries to remove an item that is not in the cart
Then the item shouldn't be removed from the cart
Examples:
| productName        |
| Headphones Model C |

Scenario: update item quantity in cart
Given user has items in the cart
When user updates the quantity of a specific item in the cart
Then the quantity of the item should be updated successfully
Examples:
| productName      | newQuantity |
| Laptop Model A   | 2           |
| Smartphone Model B| 3           |
Scenario: update item quantity to zero in cart  
Given user has items in the cart
When user updates the quantity of a specific item to zero in the cart
Then the item should be removed from the cart
Examples:
| productName      |
| Laptop Model A   |
Scenario: update item quantity with invalid value in cart   
Given user has items in the cart
When user tries to update the quantity of a specific item with an invalid value
Then the quantity of the item shouldn't be updated

Examples:
| productName      | newQuantity |
| Smartphone Model B| -1          |

Feature: checkout functionality
Scenario: successful checkout
Given user has items in the cart
When user proceeds to checkout and enters valid payment 
And shipping information
Then the order should be placed successfully

Examples:
| paymentMethod | shippingAddress       |
| Credit Card   | 123 Main St, City A  |
| PayPal        | 456 Elm St, City B   |
Scenario: checkout with empty cart
Given user has an empty cart
When user tries to proceed to checkout
Then user shouldn't be able to proceed to checkout  
Examples:
| paymentMethod | shippingAddress       |
| Credit Card   | 123 Main St, City A  |
| PayPal        | 456 Elm St, City B   |

Scenario: checkout with invalid payment information
Given user has items in the cart
When user proceeds to checkout and enters invalid payment information
Then the order shouldn't be placed successfully 
Examples:
| paymentMethod | shippingAddress       |
| InvalidCard   | 123 Main St, City A  |
| ExpiredCard   | 456 Elm St, City B   |
Scenario: checkout with missing shipping information
Given user has items in the cart
When user proceeds to checkout and leaves shipping information empty
Then the order shouldn't be placed successfully     
Examples:
| paymentMethod | shippingAddress |
| Credit Card   |                 |
| PayPal        |                 |
Scenario: checkout with insufficient stock
Given user has items in the cart
When user proceeds to checkout and one or more items are out of stock
Then the order shouldn't be placed successfully
Examples:
| paymentMethod | shippingAddress   

| Credit Card   | 123 Main St, City A|
| PayPal        | 456 Elm St, City B |


Scenario: checkout with invalid shipping address
Given user has items in the cart
When user proceeds to checkout and enters an invalid shipping address
Then the order shouldn't be placed successfully
Examples:
| paymentMethod | shippingAddress    |
| Credit Card   | 123@Main St!City A|
| PayPal        | 456#Elm St$City B |
Scenario: checkout with canceled payment
Given user has items in the cart
When user proceeds to checkout and cancels the payment process
Then the order shouldn't be placed successfully
Examples:
| paymentMethod | shippingAddress       |
| Credit Card   | 123 Main St, City A  |    
| PayPal        | 456 Elm St, City B   |
Scenario: checkout with network failure
Given user has items in the cart
When user proceeds to checkout and experiences a network failure during payment
Then the order shouldn't be placed successfully
Examples:
| paymentMethod | shippingAddress       |
| Credit Card   | 123 Main St, City A  |
| PayPal        | 456 Elm St, City B   |
Scenario:Appy discount code during checkout
Given user has items in the cart
When user applies a valid discount code during checkout
Then the order total should be updated with the discount applied
Examples:
| discountCode |    
| SAVE10       |
| FREESHIP     |
Scenario: Apply invalid discount code during checkout       
Given user has items in the cart
When user applies an invalid discount code during checkout
Then the order total shouldn't be updated   
Examples:
| discountCode  |   
| INVALIDCODE   |
| EXPIREDCODE   |
Scenario: Apply expired discount code during checkout
Given user has items in the cart
When user applies an expired discount code during checkout
Then the order total shouldn't be updated
    
Examples:
| discountCode  |
| OLDDEAL       |
| SUMMER2022    |

Scenario: Apply discount code with minimum purchase requirement not met during checkout
Given user has items in the cart
When user applies a discount code with a minimum purchase requirement not met during checkout
Then the order total shouldn't be updated
Examples:
| discountCode  |
| BIGSAVE       |
| HOLIDAY50     |   
Scenario: Apply discount code with invalid format during checkout
Given user has items in the cart
When user applies a discount code with an invalid format during checkout
Then the order total shouldn't be updated
Examples:
| discountCode  |   
| 123INVALID    |   
| SPECIAL@CODE  |
Scenario: Apply multiple discount codes during checkout
Given user has items in the cart
When user applies multiple discount codes during checkout
Then only the first valid discount code should be applied to the order total
Examples:
| discountCode1 | discountCode2 |
| SAVE10        | FREESHIP      |
| HOLIDAY20     | BIGSAVE       |
Scenario: Apply discount code after entering payment information during checkout
Given user has items in the cart
When user applies a valid discount code after entering payment information during checkout
Then the order total should be updated with the discount applied
Examples:
| discountCode |
| SAVE10       |
| FREESHIP     |
Scenario: 


