Rails.application.routes.draw do |map|
  
  scope "/admin" do
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
  end
end