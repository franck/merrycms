module ActionDispatch::Routing
  
  class Mapper
    
    def merrycms_routes
      namespace :admin do
        resources :users
        
        resources :pages do
          member do
            get 'publish'
            get 'unpublish'
            get 'archive'
            get 'unarchive'
          end
        end
        
        resources :categories do
          member do
            get 'sort'
          end
          collection do
            get 'sorting'
          end
        end
        
        resources :translations do
          collection do
            get 'dump'
          end
        end
        match 'translations/pending/:language' => 'translations#pending', :as => 'pending_translations'
        match 'translations/all/:language' => 'translations#all', :as => 'all_translations'
        
        root :to => 'pages#index'
      end
    end
    
  end
  
end