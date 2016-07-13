Rails.application.routes.draw do

	root 'articles#index'

	resources :articles

	get 'signup' => 'users#new'

	post 'signup' => 'users#create'

	resources :users, only: [:show]

	get 'login' => 'sessions#new'

	post 'login' => 'sessions#create'

	delete 'logout' => 'sessions#destroy'

end
