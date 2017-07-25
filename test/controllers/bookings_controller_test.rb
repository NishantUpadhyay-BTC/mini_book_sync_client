require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
  test "should get rental" do
    get bookings_rental_url
    assert_response :success
  end

  test "should get booking" do
    get bookings_booking_url
    assert_response :success
  end

  test "should get listing" do
    get bookings_listing_url
    assert_response :success
  end

end
