*** Settings ***
Library  Browser
Library    Collections

*** Keywords ***
I am on the search page for "${search}"
  Get Element States    id=search-suggestions-banner  contains  visible
  Get Text    css=.searchText  contains  ${search}

the selected sorting method is "${method}"
  Get Selected Options    id=list-sort-select    label    contains    ${method}

I sort the list by "${method}"
  Select Options By    id=list-sort-select    label    ${method}

I open the first product page
    Click    xpath=(//*[contains(concat(' ', normalize-space(@class), ' '), ' product-list ')]/*)[1]//a[./img]

The sellers are displayed correctly
    
    @{list}=  Create List    Decathlon    Balles de Sport    Sport & Go    Butyjana    Sportano EU
      
    ${count}=  Get Length  ${list}
    FOR    ${index}    IN RANGE    1    ${count + 1}
        Log    ${index}
        ${seller}=  Get From List  ${list}  ${index - 1}

        Get Text  xpath=(//summary[.//*[contains(text(), 'Filtrer par vendeurs')]]/following-sibling::div//a)[${index}]  contains  ${seller}
        # //summary[.//*[contains(text(), 'Filtrer par vendeurs')]]/following-sibling::div
    END

there are "${seller_count}" sellers lsted
    Get Element Count    xpath=(//summary[.//*[contains(text(), 'Filtrer par vendeurs')]]/following-sibling::div//a)    equals    ${seller_count}

   @{list_on_page}=  Get Elements   xpath=(//summary[.//*[contains(text(), 'Filtrer par vendeurs')]]/following-sibling::div//a)

   @{list_of_sellers}=  Create List

    FOR    ${seller}    IN    @{list_on_page}
        Log  ${seller}
        ${text}=  Get Text  ${seller}
        Append To List    ${list_of_sellers}    ${text}
    END 

    ${list_count}=  Get Length  ${list_of_sellers}
    Should Be Equal As Integers  ${seller_count}    ${list_count}