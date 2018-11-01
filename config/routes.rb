Rails.application.routes.draw do
  root 'rooms#index'
  post 'rooms/create' => 'rooms#create', as: 'new_room'
  devise_for :users
	resources :rooms, only: [:show, :destroy]
	delete 'message/:id' => 'rooms#message_destroy', as: 'message'
	get 'rooms/check_password/:room_id' => 'rooms#check_password', as: 'check_password'
	post 'rooms/create_session' => 'rooms#create_session', as: 'create_session'
end
