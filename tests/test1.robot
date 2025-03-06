*** Settings ***
Library  Browser
Resource  ../resources/homepage_page.resource
Resource  ../resources/search_page.resource
Resource  ../resources/login_page.resource
Resource  ../resources/searchbar_element.resource
Resource  ../resources/product_page.resource
Resource  ../resources/cart_page.resource
#Resource  ../data/products.py

Test Setup  Given I am on the homepage

*** Variables ***
&{product1}  ref=8549582  name=BALLON DE GYM RÉSISTANT - Swissball - 65 CM - Argent

*** Test Cases ***
Test 1
    No Operation

Test 2
    When I search for "ballon"
    Then I am on the search page for "ballon"

Test 3
    When I go to the login form
    Then I am on the login form
    When I try to connect with the email address "toto@yopmail;com"
    Then I have an error for a wrong email address

Test 4
    When I search for "ballon"
    Then I am on the search page for "ballon"
    And the selected sorting method is "Meilleures ventes"
    When I sort the list by "Note des clients"
    Then the selected sorting method is "Note des clients"

Test 6
    When I search for "ballon"
    Then I am on the search page for "ballon"
    When I open the first product page
    Then I am on the product page for "BALLON DE GYM RÉSISTANT - Swissball - 65 CM - Argent"
    When I add the product to the cart
    Then the product is added to the cart successfully
    When I go to the cart
    Then the cart is displayed
    And there are "1" product(s) in the cart
    And the product "BALLON DE GYM RÉSISTANT - Swissball - 65 CM - Argent" is in the cart

Test 7
    When I search for "8549582"
    And I add the product to the cart
    Then the product is added to the cart successfully
    When I close the cart popin
    And I search for "8336573"
    And I add the product to the cart
    Then the product is added to the cart successfully

Test 8
    When I search for "ballon"
    Then I am on the search page for "ballon"
    And The sellers are displayed correctly
    
Test 9 
    When I search for "ballon"
    Then I am on the search page for "ballon"
    And there are "74" sellers lsted
    And The sellers are displayed correctly

Test 10
    Log Many  ${product1}
    When I search for "${product1.ref}"
    Then I am the product page for "${product1.name}"
    When I add the product to the cart
    Then the product is added to the cart successfully
    When I go to the cart
    Then the cart is displayed