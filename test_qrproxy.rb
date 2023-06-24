require 'minitest/autorun'
require 'selenium-webdriver'
require 'webdrivers'

class QRProxyTest < MiniTest::Test 
  def setup 
    @browser = Selenium::WebDriver.for :chrome 
    @wait = Selenium::WebDriver::Wait.new(:timeout => 15) #not sure if I need to keep this line
  end
  
  def test_qrproxy
    ## check that the title matches the title in the browser
    @browser.navigate.to "https://www.qrcode-monkey.com/#url"
    assert(@browser.title.include? "QRCode Monkey - The free QR Code Generator")

    ## check single color radio button is enabled by default
    @single_color = @browser.find_element(:name => "colorMode", :value => "single")
    assert(@single_color.enabled?)

    ## check that custom eye color checkbox is NOT selected by default
    @cb = @browser.find_element(:css, 'input[ng-model="customEyeColor"]')
    assert(@cb.selected? == false)

    ## check that create qr code button is enabled by default
    @generate = @browser.find_element(:id, "button-create-qr-code")
    assert(@generate.enabled?)

    # @generate.execute_script('arguments[0].click()', button)
    # assert(@generate.enabled? == false)
    # pp @generate.rect
    
    # @generate.click(x: 5, y: 5)
    # @wait.until { @browser.find_element(:css, "img.qrimage").displayed? }
  end
end