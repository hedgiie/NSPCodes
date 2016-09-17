#=======================================================================================================================
# Author: Nel Pontejos
# Created: Sept 14, 2016
#  * Customer registration page
#=======================================================================================================================

require_relative ENV['FCTEST']+'/Source/Pages/base_page'

class RegistrationPage < BasePage

  def click_sign_in_link
    find_element_link_click 'Sign in'
  end

  def fill_email_create_account_txt email_address
    fill_text_field_id 'email_create', email_address
  end

  def fill_email_sign_in_txt email_address
    fill_text_field_id 'email', email_address
  end

  def click_create_an_account_btn
    find_element_id_click 'SubmitCreate'
  end

  def click_sign_in_btn
   find_element_id_click 'SubmitLogin'
    sleep 2
  end

  def click_log_out_btn
    find_element_link_click 'Sign out'
  end

  def fill_first_name_txt first_name
    fill_text_field_id 'customer_firstname', first_name
  end

  def fill_last_name_txt last_name
    fill_text_field_id 'customer_lastname', last_name
  end

  def fill_password_txt password
    fill_text_field_id 'passwd', password
  end

  def fill_address_txt address
    fill_text_field_id 'address1', address
  end

  def fill_city_txt city
    fill_text_field_id 'city', city
  end

  def click_state_dd item
    find_element_id_click 'id_state'
    find_element_xpath_click "//select[@id='id_state']/option[2]"
  end

  def fill_zip_postal_code_txt zip_postal_code
    fill_text_field_id 'postcode', zip_postal_code
  end

  def fill_mobile_phone_txt mobile_phone
    fill_text_field_id 'phone_mobile', mobile_phone
  end

  def click_register_btn
    find_element_id_click 'submitAccount'
  end


end
