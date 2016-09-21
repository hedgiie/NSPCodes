#=======================================================================================================================
# Author: Nel Pontejos
# Created: Sept 16, 2016
#   * Verify that a Blue Faded Short Sleeve T-shirt can be purchased in
#     Medium size and delivered by “My carrier Delivery next day!”
#   * Verify the cost is  $18.51 with tax included
#=======================================================================================================================

require_relative ENV['FCTEST']+'/Framework/fincadtest'


class TcPurchasePrice < FinCadTest

  def setup
    puts "setup within TcPurchasePrice..."
    initializers
  end

  def test_create_information
    Registration.open_url
    ProductPurchase.log_in
    ProductPurchase.select_product_item_to_checkout
    ProductPurchase.process_checkout_to_shipping
    assert_text_found $data['fincad_test']['asserts']['product_purchase']['shipping_method_msg'], Registration.get_text
    ProductPurchase.process_checkout_to_payment
    content =  Registration.get_text
    assert_text_found $data['fincad_test']['asserts']['product_purchase']['blue_med_shirt_color_size'], content
    assert_text_found $data['fincad_test']['asserts']['product_purchase']['total_price'], content
  end

  def teardown
    $log.note "in tear down"
  ensure
    Registration.log_out
    Registration.close_url
    $log.note "done tear down"
  end
end


