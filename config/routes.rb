Rails.application.routes.draw do
  root 'articles#index'
  get '/:year/:month/:day/:slug', to: 'articles#show', as: :article

  get '*anything', to: redirect('/')
end
