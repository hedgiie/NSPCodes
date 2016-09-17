#=======================================================================================================================
# Author: Nel Pontejos
# Created: Sept 14, 2016
#   * Loaders
#   * Asserts
#=======================================================================================================================

require 'minitest/autorun'
require_relative ENV['FCTEST']+'/Source/Scenarios/Customer/registration'
require_relative ENV['FCTEST']+'/Source/Scenarios/Transaction/product_purchase'

class FinCadTest < MiniTest::Test

  def initializers
    puts "in FCTest init"

    Registration.load_page
    
    ProductPurchase.load_page

    ## includes all essential initializer
    Registration.load_driver
  end

  def assert_text_found( text_to_find, text_input, message = " - failed: message not found" )
    if ! /#{text_to_find}/.match( text_input ).nil?
      $log.note "#{self.class.name} | #{text_to_find} | is found in | #{text_input}"
    else
      $log.fail_msg "#{self.class.name} | #{text_to_find} | is not found in | #{text_input}"
    end

    if assert(! /#{text_to_find}/.match( text_input ).nil?, message)
      $log.passed text_to_find
    end
  end

end