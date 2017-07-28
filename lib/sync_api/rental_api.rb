module SyncApi
  module RentalApi
    def create_rental(params)
      binding.pry
      send_http_request('/rentals', :post, params)
    end
  end
end
