#=======================================================================================================================
# Author: Nel Pontejos
# Created: Sept 15, 2016
#   * Verify missing zip/postal code
#   * Verify completed registration
#=======================================================================================================================

require_relative ENV['FCTEST']+'/Framework/fincadtest'


class TcCustomerRegistration < FinCadTest

  def setup
    puts "setup within TcCustomerRegistration..."
    initializers
  end

  def test_create_information
    Registration.open_url
    Registration.navigate_to_registration
    Registration.fill_registration_info_missing_zip_postal_code
    Registration.click_register_btn
    assert_text_found $data['fincad_test']['asserts']['error_msg']['missing_zip_postal_code'], Registration.get_text
    Registration.fill_required_registration_info
    Registration.click_register_btn
    assert_text_found $data['fincad_test']['asserts']['error_msg']['my_account'], Registration.get_text
  end

  def teardown
    $log.note "in tear down"
    ensure
      Registration.close_url
      $log.note "done tear down"
  end
end


