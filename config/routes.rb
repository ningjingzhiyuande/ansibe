Ansible::Application.routes.draw do
  resources :net_cards do
    member do    #  requests/30/approve
      put :approve
      put :reject
      put :review
    end
  end

  resources :attendances do
    # 对某个request   的实力进行操作，比如： Request.find(id).reject....
    member do    #  requests/30/approve
      put :approve
      put :reject
      put :review
    end
    
    # 不需要 id 这个参数，就可以直接执行需要的代码。比如：    Request.delete_all   ,     puts " hellow, world"
 #    collection do   # requests/hi
 #      get :hi
  	# end
  end

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end