# Bitly Jr. SDET Challenge
- languages and tools used:
  - Ruby `(2.7.4)`, MiniTest, Selenium WebDriver

- gem install `selenium-webdriver` 
- run $`bundle install` 
- For this challenge I instantiated `chrome` as my web `browser/driver`, however you may utilize a different browser (e.g. `firefox`) as long as you instantiate it within the `setup method`.
  - `@browser = Selenium::WebDriver.for :chrome` 