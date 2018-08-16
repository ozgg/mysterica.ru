Rails.application.routes.draw do
  get 'sitemap.xml' => 'sitemap#show', defaults: { format: :xml }

  scope '(:locale)', constraints: { locale: /ru|en/ } do
    root 'index#index'
  end
end
