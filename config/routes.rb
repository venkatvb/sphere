Rails.application.routes.draw do
	match '/doc' => 'apidoc#index', :via => [:get], :as => 'doc_index'	
	match 'status/:id' => 'status#get', :via => [:get], :as => 'status'
	match 'trending' => 'trending#get', :via => [:get], :as => 'trending'  
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	# Serve websocket cable requests in-process
	# mount ActionCable.server => '/cable'
end
