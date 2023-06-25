require 'minitest/autorun'
require 'selenium-webdriver'
require 'webdrivers'

class QRProxyTest < MiniTest::Test 
  def setup 
    @browser = Selenium::WebDriver.for :chrome 
    @wait = Selenium::WebDriver::Wait.new(:timeout => 15) #not sure if I need to keep this line
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

    ## user downloads QR code as PNG
    ## user quits browser 
  end

  ## Scenario Two: User customizes their inputs before generating qr code
  def test2_qrproxy
    ## check when add_logo pane/row is clicked on, it turns the pane editing view to active"
    @add_logo = @browser.find_element(:class, "pane")
    @browser.execute_script("arguments[0].click();", @add_logo)
    assert(@add_logo[:class] == "pane active")

    ## customize URL input
    @input_url = @browser.find_element(:name, "qrcodeUrl")
    @input_url.send_keys('https://www.myqrcode.com')

    expected_result = 'https://www.myqrcode.com'
    actual_result = @input_url.attribute('value')
    assert(expected_result == actual_result)

    ## customize colors 

  end
end
    
    ## for foreground color, if the color is too light (>= 160) an alert pops up 'we recommend to make your color darker'
