Rails.application.routes.draw do
  get 'bookings/rental'

  get 'bookings/booking'

  get 'bookings/listing'

  root 'bookings#listing'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
