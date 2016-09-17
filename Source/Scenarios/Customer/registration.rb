#=======================================================================================================================
# Author: Nel Pontejos
# Created: Sept 14, 2016
#   * Covers customer registration behaviour
#=======================================================================================================================

require_relative ENV['FCTEST']+'/Source/Pages/Customer/registration_page'

class Registration
  ## start of LOADERS #########

  def self.load_page
    @@registration_page = RegistrationPage.new
  end

  def self.load_driver
    @@registration_page.load_driver
  end
  ## end of LOADERS ##########

  ## start of PARAMETARIZED behaviours ###
  def self.navigate_to_registration
    $log.note "** navigating to registration page... **"
    $log.note "1. click on \"sign in\" link"
    @@registration_page.click_sign_in_link

    $log.note "2. fill email field: #{$data['customer']['registration']['email_address']}#{(Time.now.to_f * 1000).floor}"
    @@registration_page.fill_email_create_account_txt "#{$data['customer']['registration']['email_address']}#{(Time.now.to_f * 1000).floor}"

    $log.note "3. click on \"create an account\" button"
    @@registration_page.click_create_an_account_btn
  end

  def self.fill_registration_info_missing_zip_postal_code
    $log.note "** fill registration form, except zip/postal code... **"

    $log.note "1. fill first name field: #{$data['customer']['registration']['first_name']}"
    @@registration_page.fill_first_name_txt $data['customer']['registration']['first_name']

    $log.note "2. fill last name field: #{$data['customer']['registration']['last_name']}"
    @@registration_page.fill_last_name_txt $data['customer']['registration']['last_name']

    $log.note "3. fill password field: #{$data['customer']['registration']['password']}"
    @@registration_page.fill_password_txt $data['customer']['registration']['password']

    $log.note "4. fill address field: #{$data['customer']['registration']['address']}"
    @@registration_page.fill_address_txt $data['customer']['registration']['address']

    $log.note "5. fill city field: #{$data['customer']['registration']['city']}"
    @@registration_page.fill_city_txt $data['customer']['registration']['city']

    $log.note "6. select state from drop down: Alabama"
    @@registration_page.click_state_dd $data['customer']['registration']['state'] # alabama, 1st item

    $log.note "7. fill mobile phone field: #{$data['customer']['registration']['mobile_phone']}"
    @@registration_page.fill_mobile_phone_txt $data['customer']['registration']['mobile_phone']
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

  def self.log_out
    @@registration_page.click_log_out_btn
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


