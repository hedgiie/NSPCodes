#=======================================================================================================================
# Author: Nel Pontejos
# Created: Sept 16, 2016
#  * Product purchase page
#=======================================================================================================================

require_relative ENV['FCTEST']+'/Source/Pages/base_page'

class TransactionPage < BasePage

  def click_add_to_cart_btn
    find_element_name_click 'Submit'
    sleep 2
  end

  def click_proceed_to_checkout_summary_btn
    find_element_xpath_click "//div[@id='center_column']/p[2]/a/span"
  end

  def click_proceed_to_checkout_address_btn
    find_element_name_click "processAddress"
  end

  def click_proceed_to_checkout_shipping_btn
    find_element_name_click "processCarrier"
  end

  def click_terms_agreement_cb
    find_element_id_click "cgv"
  end

  def click_register_btn
    find_element_id_click 'submitAccount'
  end


end
