Spree::Core::Engine.add_routes do
  # Add your extension routes here
  namespace :admin do
    resources :clouds
    resources :products do
      resources :images do
        collection do
          get :filter_cloud_assets
        end
      end
    end
  end
end
