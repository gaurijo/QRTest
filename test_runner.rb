require 'minitest/autorun'
require 'selenium-webdriver'
require 'webdrivers'

class QRProxyTest < MiniTest::Test 
  def setup 
    @browser = Selenium::WebDriver.for :chrome 
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10) #not sure if I need to keep this line
  end
  
  ##Scenario: User navigates to the website, and does not change anything, website should generate a default QR code:
  def test_qrproxy
    ## check that the title matches the title in the browser
    @browser.navigate.to "https://www.qrcode-monkey.com/#url"
    assert(@browser.title.include? "QRCode Monkey - The free QR Code Generator")

    ## check single color radio button is enabled by default
    @single_color = @browser.find_element(:name => "colorMode", :value => "single")
    @gradient = @browser.find_element(:name => "colorMode", :value => "gradient")
    assert(@single_color.enabled?)

    ## check that gradient radio button is selected when clicked on
    @browser.execute_script("arguments[0].click();", @gradient)
    assert(@gradient.selected?)

    ## check that custom eye color checkbox is NOT selected by default
    @cb = @browser.find_element(:css, 'input[ng-model="customEyeColor"]')
    assert(@cb.selected? == false)

    ## check that create qr code button is enabled by default
    @generate = @browser.find_element(:id, "button-create-qr-code")
    assert(@generate.enabled?)

    ## check that create qr code button is disabled once a user clicks on it
    @browser.execute_script("arguments[0].click();", @generate)
    assert(@generate.enabled? == false)

    #todo: user downloads QR code as PNG

    ## user quits browser 
    # @browser.quit 

  ## Scenario 2: User customizes their inputs before generating qr code
  #todo: add a logo or upload image logo
    ## check when add_logo pane/row is clicked on, it turns the pane editing view to active"
    @add_logo = @browser.find_element(:class, "pane")
    @browser.execute_script("arguments[0].click();", @add_logo)
    assert(@add_logo[:class] == "pane active")

    #finds the preview for no logo
    @no_logo = @browser.find_elements(:xpath, "//div[@class='placeholder']//span[text()='No Logo']")
    assert(@no_logo.any?)

    # @logo_preview = @new_logo.find_element(:class, "placeholder")
    # @browser.execute_script("arguments[0].click();", @new_logo)
    # assert(@logo_preview[:class] == "placeholder ng-hide")
    #todo: change design pattern
  end
  
  #todo: customize colors 
  # @color_picker = @browser.find_element(:css, "background-color")
  # @new_color = 'red'
  # actual_color = @color_picker.attribute("background-color")
  # expected_color = 'rgb(255, 0, 0)'
  # assert(actual_color == expected_color)
  ## Scenario 3: Error Handling -- if a user tries to implement something they cannot or should not they will get an alert
  ## for foreground color, if the color is too light (>= 160) an alert pops up 'we recommend to make your color darker'
end
    
