Rails.application.routes.draw do
  root 'articles#index'
  get '/:year/:month/:day/:title', to: 'articles#show', as: :article
end
