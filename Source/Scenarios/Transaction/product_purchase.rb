#=======================================================================================================================
# Author: Nel Pontejos
# Created: Sept 14, 2016
#   * Covers customer registration behaviour
#=======================================================================================================================

require_relative ENV['FCTEST']+'/Source/Pages/Transaction/transaction_page'

class ProductPurchase
  ## start of LOADERS #########

  def self.load_page
    @@transaction_page = TransactionPage.new

    @@registration_page = RegistrationPage.new
  end

  def self.load_driver
    @@transaction_page.load_driver
  end
  ## end of LOADERS ##########

  ## start of PARAMETARIZED behaviours ###
  def self.log_in
    $log.note "** log in... **"
    $log.note "1. click on \"sign in\" link"
    @@registration_page.click_sign_in_link

    $log.note "2. fill email field: #{$data['customer']['registration']['email_address']}"
    @@registration_page.fill_email_sign_in_txt $data['customer']['registration']['email_address']

    $log.note "3. fill password field: #{$data['customer']['registration']['password']}"
    @@registration_page.fill_password_txt $data['customer']['registration']['password']

    $log.note "4. click sign in button..."
    @@registration_page.click_sign_in_btn
  end

  def self.select_product_item_to_checkout
    $log.note "** selecting product item... **"

    $log.note "1. set blue t shirt | medium..."
    @@transaction_page.open_page "http://automationpractice.com/index.php?id_product=1&controller=product#/size-m/color-blue"

    $log.note "2. add to cart..."
    @@transaction_page.click_add_to_cart_btn

    $log.note "3. navigate to checkout page..."
    @@transaction_page.open_page "http://automationpractice.com/index.php?controller=order"

  end

  def self.process_checkout_to_shipping
    sleep 2
    $log.note "1. click \"proceed to checkout\" button | summary..."
    @@transaction_page.click_proceed_to_checkout_summary_btn
    sleep 2
    $log.note "2. click \"proceed to checkout\" button | address..."
    @@transaction_page.click_proceed_to_checkout_address_btn
    sleep 2
  end

  def self.process_checkout_to_payment
    sleep 2
    $log.note "click \"proceed to checkout\" button | shipping..."
    @@transaction_page.click_terms_agreement_cb
    @@transaction_page.click_proceed_to_checkout_shipping_btn
    sleep 2
  end

  def self.fill_required_registration_info
    $log.note "** fill required registration info... **"

    $log.note "1. fill postal code: #{$data['customer']['registration']['zip_postal_code']}"
    @@registration_page.fill_zip_postal_code_txt $data['customer']['registration']['zip_postal_code']

    $log.note "2. fill password field: #{$data['customer']['registration']['password']}"
    @@registration_page.fill_password_txt $data['customer']['registration']['password']
  end

  def self.click_register_btn
    $log.note "**clicking register button... **"
    @@registration_page.click_register_btn
    sleep 2
  end

  def self.login_message
    @@authentication_page.status_message
  end
  ## end of PARAMETARIZED behaviours ###

  ## start of NON-PARAMETARIZED behaviours ###
  def self.open_url
    @@registration_page.open_url
  end

  def self.close_url
    @@registration_page.close_url
  end

  def self.get_text
    @@registration_page.get_text_tagname 'BODY'
  end

  def self.get_css_text
    @@registration_page.get_text_css 'ol > li'
  end

  ## end of NON-PARAMETARIZED behaviours ###

end


