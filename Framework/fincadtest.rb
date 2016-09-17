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

  def text_found( text_to_find, text_input)
    $log.note "evaluating if #{text_to_find} is equal to #{text_input}"
    if ! /#{text_to_find}/.match( text_input ).nil?
      $log.note "#{self.class.name} | #{text_to_find} is equal to #{text_input}"
      return true
    else
      $log.warning "#{self.class.name} | #{text_to_find} is not equal to #{text_input}"
      return false
    end
  end

  def not_empty_string( string, text_input )
    $log.note "evaluating if #{string} is not empty | #{text_input}"
    if  string != ''
      $log.note "#{text_input} is not empty"
      return true
    else
      $log.warning "#{text_input} is empty"
      return false
    end
  end

  def assert_not_empty_string( string, text_input, message = " - failed: empty value" )

    if  string != ''
      $log.note "#{text_input} is not empty"
    else
      $log.fail_msg "#{text_input} is empty"
    end

    if assert( string != '', message)
      $log.passed text_input
    # else
    #   $log.fail_msg message
    end
  end

end