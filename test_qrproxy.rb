require 'minitest/autorun'
require 'selenium-webdriver'
require 'webdrivers'

class QRProxyTest < MiniTest::Test 
  def setup 
    @browser = Selenium::WebDriver.for :chrome 
  end

  def test_qrproxy
    @browser.navigate.to "https://www.qrcode-monkey.com/#url"
    assert(@browser.title.include? "QRCode Monkey - The free QR Code Generator")
  end
end