OpticalFlow::Application.routes.draw do
  resources :videos
  resources :workers

  root :to => redirect('/videos')
end
