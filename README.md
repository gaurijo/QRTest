# Bitly Jr. SDET Challenge
## Built with:
  ![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
  ![Selenium](https://img.shields.io/badge/-selenium-%43B02A?style=for-the-badge&logo=selenium&logoColor=white) 

## Install and Run on your local machine:
- gem install `selenium-webdriver` 
- $`bundle install` 
- For this challenge I instantiated `chrome` as my web `browser/driver`, however you may utilize a different browser (e.g. `firefox`) as long as you instantiate it within the `setup method`.
  - `Selenium::WebDriver.for {:browser_name}`
- in terminal, run $`ruby test_runner.rb`
  - ![Screen Shot 2023-06-27 at 2 41 37 PM](https://github.com/gaurijo/QRTest/assets/103534307/29a3c50b-8959-44dd-ac7d-48f8ace99833)
## Design Decisions && Implementation

### Why Selenium WebDriver?
  - As an open source automation tool, it is easy to learn and implement
  - Agnostic in regards to programming language, browser, and operating system; this provides a lot of flexibility for testing
  - No need to start a server to use it
  - Mimics real user scenarios, including mouse cursor and keyboard simulation
### Scenarios being tested:
  1. Default - The first scenario tests the default functionality of the QRcode Monkey website and creates a QR code without making any custom changes
  > checks that the single color radio button is enabled by default, custom eye color checkbox is not selected, the button to create a QR code is enabled, and there is no logo selected. It also checks that the QR code button is disabled when the user generates the QR code, and that the user can download their QR code as a default png file.
  2. Custom Inputs - This scenario tests how a user can customize some of the inputs before generating their QR code
  > checks that the logo element is not active at first, but when a pre-selected logo is clicked the element is activated; checks that after clicking on 'body shape' the shape element is activated.
  3. Error Handling - The third scenario checks if proper alerts are triggered if a user interacts with a component in a way they shouldn't
  > checks that alert is hidden by default, if a user changes the background color of the QR code to a color that is deemed too light, an alert should populate telling the user they should change the color to something darker.
## Resources 
- [Ruby Docs](https://ruby-doc.org/core-2.7.4/)
- [MiniTest](https://ruby-doc.org/stdlib-3.1.1/libdoc/minitest/rdoc/Minitest/Assertions.html)
- [Selenium WebDriver](https://www.selenium.dev/documentation/webdriver/)
