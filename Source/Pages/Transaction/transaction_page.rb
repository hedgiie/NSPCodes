#=======================================================================================================================
# Author: Nel Pontejos
# Created: Sept 16, 2016
#  * Product purchase page
#=======================================================================================================================

require_relative ENV['FCTEST']+'/Source/Pages/base_page'

class TransactionPage < BasePage

  def click_tshirt_menu
    sleep 2
    find_element_xpath_click '(//a[contains(text(),\'T-shirts\')])[2]'
    sleep 2
  end

  def click_shirt_product
    find_element_css_click 'a.product_img_link > img.replace-2x.img-responsive'
  end

  def click_shirt_size size
    find_element_name_click 'uniform-group_1'
    select_id_drop_down_item_
    find_element_xpath_click "//option[@value='2']"
  end

  def click_blue_icon
    find_element_id_click 'color_14'
  end

  def click_add_to_cart_btn
    find_element_name_click 'Submit'
    sleep 2
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

  def click_state_dd item
    # select_id_drop_down_item 'id_state'
    find_element_id_click 'id_state'
    # find_element_css_click '#id_state > option[value=\"#{item}\"]'
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
