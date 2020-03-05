Feature: Access the Home Page

@home
Scenario: Visit the home page
    Given I access the webpage 
    And I fill the form with origin and destiny 
    Then I should see results in the Clickbus search result