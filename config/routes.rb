Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      post "/imports", to: "imports#create"
      post "/import_details", to: "import_details#create"
      post "/login", to: "login#create"
    end
  end
end
