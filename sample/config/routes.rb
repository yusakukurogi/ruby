Rails.application.routes.draw do
  resources :books do
    collection do
      post :import
    end
  end
end

  