Visualizer::Application.routes.draw do
  resources :uploaded_files
  resources :datasets, :only => [:create, :add] do
    member do
      post 'add'
      get  'processing_status'
    end
  end

  match '/' => 'maps#index'
  match '/tiles/:zoom/:column/:row' => 'maps#tiles'
  match '/datasets/:id.json' => 'maps#json_query'
  match '/datasets/:id/ranges.json' => 'maps#ranges'
  match '/maps/:id' => 'maps#show', :as => :dataset
  match '/maps/:id/embeded' => 'maps#embeded', :as => :embeded
end
