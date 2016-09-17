########################################################################################################################
# Author: Nel Pontejos
# Sept 15, 2016
#   This class should provide methods for accessing web elements from it's supper class web driver methods.
########################################################################################################################

require 'selenium-webdriver'
require 'net/http'
require 'net/https'
require 'uri'

require_relative ENV['FCTEST']+'/Framework/web_driver'

class BasePage < WebDriver

  def find_element_id_clear web_element
    $driver.find_element(:id, web_element).clear
  end

  def find_element_id_send_keys web_element, key
    $driver.find_element(:id, web_element).send_keys key
  end

  def find_element_id_click web_element
    $driver.find_element(:id, web_element).click
  end

  def find_element_name_click web_element
    $driver.find_element(:name, web_element).click
  end


  def find_element_tagname tag_name
    $driver.find_element(:tag_name, tag_name).text
  end

  def find_element_link link_name
    $driver.find_element(:link, link_name).text
  end

  def find_element_link? link_name
    $driver.find_element(:link, link_name).size != 0
  end

  def find_element_link_click link_name
    $driver.find_element(:link, link_name).click
  end

  def find_element_css_click web_element
    $driver.find_element(:css, web_element).click
  end

  def find_element_xpath_click web_element
    $driver.find_element(:xpath, web_element).click
  end

  def find_element_xpath_text web_element
    $driver.find_element(:css, web_element).text
  end

  def find_element_name_clear web_element
    $driver.find_element(:name, web_element).clear
  end

  def find_element_name_send_keys web_element, key
    $driver.find_element(:name, web_element).send_keys key
  end


  # utility methods
  def fill_text_field_id web_element, key
    $driver.find_element(:id, web_element).click
    $driver.find_element(:id, web_element).clear
    $driver.find_element(:id, web_element).send_keys key
  end

  # getters

  def get_text_id web_element
    $driver.find_element(:id, web_element).text
  end

  def get_text_css web_element
    $driver.find_element(:css, web_element).text
  end

  def get_text_tagname web_element
    $driver.find_element(:tag_name, web_element).text
  end

  def select_id_drop_down_item web_element
    Selenium::WebDriver::Support::Select.new($driver.find_element(:id, web_element))
  end

  def select_id_drop_down_item_
    Selenium::WebDriver::Support::Select.new($driver.find_element(:id, "group_1")).select_by(:text, "M")
  end

  def open_page url
    $driver.navigate.to url
  end

end
