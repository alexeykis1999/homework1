Rails.application.routes.draw do
	scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  	root "articles#index"
  	resources :articles
  end
end


