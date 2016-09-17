#=======================================================================================================================
# Sample Test: Automation Engineer Assignment
# Author: Nel Pontejos
# Created: Sept 14, 2016
#   * Handles selenium web driver manipulation
#=======================================================================================================================

require 'selenium-webdriver'
require 'net/http'
require 'net/https'
require 'uri'

require_relative ENV['FCTEST']+'/Framework/Utilities/json_helper'
require_relative ENV['FCTEST']+'/Framework/Logging/test_logger'
require_relative ENV['FCTEST']+'/Framework/Utilities/date_time_stamp'
require_relative ENV['FCTEST']+'/Framework/Utilities/directory_utilities'

require_relative ENV['FCTEST']+'/Data/data_reader'

class WebDriver

    def load_driver
        $config = read_json ENV['FCTEST']+'/config.json'
        puts "starting to test log...1"
        puts "output is #{defined? $log}"

        if defined? $log != "global-variable"
          puts "log is not been defined"
        else
          puts "log has been defined"
        end

        if $log.nil?
          logger_initializer
        end
        puts "output is: #{defined? $log}"
        puts "starting to test log...2"


        if ARGV.length == 0
          @base_url = $config[ENV['FCTEST_ENV']]['host']
          $driver = Selenium::WebDriver.for $config[ENV['FCTEST_ENV']]['target_browser'].to_sym
        else
          @base_url = $config[ARGV[0]]['host']
          $driver = Selenium::WebDriver.for $config[ARGV[0]]['target_browser'].to_sym
        end

        @accept_next_alert = true
        $log.note 'initializing data...start'
        DataReader.initialize
        $log.note 'initializing data...done'
        $driver.manage.timeouts.implicit_wait = 300
        $driver.manage.timeouts.script_timeout = 300
        $driver.manage.timeouts.page_load = 300
        $log.note 'maximizing windows...'
        $driver.manage.window.maximize

    end

    def logger_initializer
      date_time_stamp = create_date_time_stamp()
      if ARGV.length == 0
        base_output_folder = $config[ENV['FCTEST_ENV']]['output_folder']
      else
        base_output_folder = $config[ARGV[0]]['output_folder']
      end

      create_directory("#{ENV['FCTEST']}#{base_output_folder}")

      logging_directory = "#{ENV['FCTEST']}#{base_output_folder}Logs/"
      create_directory(logging_directory)
      program_name = get_program_name $0
      $log = TestLogger.new(program_name, logging_directory, date_time_stamp)
      $log.note "logger initialized..."
    end

    def open_url
      $log.note "opening url: #{@base_url}"
       # $driver.navigate.to @base_url + '/login' # landing page will always be the login page. for this automation
      $driver.navigate.to @base_url
      $log.note "opened url: #{@base_url}"
    end

    def close_url
      $driver.quit
    end

    def element_present?(how, what)
      $driver.find_element(how, what)
      true
    rescue Selenium::WebDriver::Error::NoSuchElementError
      false
    end

    def alert_present?()
      $driver.switch_to.alert
      true
    rescue Selenium::WebDriver::Error::NoAlertPresentError
      false
    end

    def verify(&blk)
      yield
    rescue Test::Unit::AssertionFailedError => ex
      @verification_errors << ex
    end

    def close_alert_and_get_its_text(how, what)
      alert = @driver.switch_to().alert()
      alert_text = alert.text
      if (@accept_next_alert) then
        alert.accept()
      else
        alert.dismiss()
      end
      alert_text
    ensure
      @accept_next_alert = true
    end

end
