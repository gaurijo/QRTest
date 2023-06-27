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

    ## finds the preview for no logo
    @no_logo = @browser.find_elements(:xpath, "//div[@class='placeholder']//span[text()='No Logo']")
    assert(@no_logo.any?)
    #todo: create QR code
    #todo: user downloads QR code as PNG

    ## user quits browser 
    # @browser.quit

  ##Scenario 2: User customizes their inputs before generating qr code
    ## check when add_logo pane/row is clicked on, it turns the pane editing view to active
    @add_logo = @browser.find_element(:class, "pane")
    @browser.execute_script("arguments[0].click();", @add_logo)
    assert(@add_logo[:class] == "pane active")

    ## assert that the class attribute for the logo element is NOT active at first
    @logo_element = @browser.find_element(:css, "div.shape.ng-scope")
    @class = @logo_element.attribute("class")
    assert(!@class.include?("active"))
    
    ## after clicking on a pre-selected logo, check that the logo element class attribute turns to active
    @browser.execute_script("arguments[0].click();", @logo_element)
    @updated_class = @logo_element.attribute("class")
    assert(@updated_class.include?("active"))

    ## after clicking on a body shape, check that the class for that shape element is turned to active
    @design_pattern = @browser.find_element(:css, "div.shape.ng-scope i.sprite.sprite-body.sprite-square")
    @parent_div = @design_pattern.find_element(:xpath, "./ancestor::div[contains(@class, 'shape')][contains(@class, 'active')]")

    @browser.execute_script("arguments[0].click();", @design_pattern)

    @updated_design = @parent_div.attribute("class")

    assert(@updated_design.include?("active"))

    #todo: test eye frame shape if you have time 


  ##Scenario 3: Error Handling -- if a user tries to implement something they cannot or should not they will get an alert
    @alert = @browser.find_element(:css, "div.fade-animation.alert.alert-warning.ng-hide")
    assert(!@alert.displayed?)

    #access the element to pick a color that's too light
    input_color = "rgb(246, 234, 234)"
    input_color_element = @browser.find_element(:class, "color-picker-overlay")
    @browser.execute_script("arguments[0].setAttribute('style', 'background-color: #{input_color}; opacity: 1')", input_color_element)
    
    #access the color error text that is not hidden
    @visible_alert = @browser.find_element(:css, "div.fade-animation.alert.alert-warning")
    @visible_text = @visible_alert.attribute('innerText').strip

    puts "#{@visible_text}"
    assert(@visible_text == "We recommend to make your color darker")
  end
end

    
