Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/schedules', to: 'schedule#index'
  get '/schedule/:id', to: 'schedule#show'
  post '/schedules/:id/appointments', to: 'appointment#create'
  post '/schedules', to: 'schedule#create'
  delete 'schedules/:id/appointments/:num', to: 'appointment#destroy'
  delete '/schedules/:id', to: 'schedule#destroy'
end
