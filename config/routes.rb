MbkStation::Application.routes.draw do

  # get '/', to: redirect('/')
  match 'home' => 'home#index'

  # Sample of regular route:
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
end
