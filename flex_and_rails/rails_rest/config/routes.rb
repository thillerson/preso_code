ActionController::Routing::Routes.draw do |map|
  map.resources :tasks

  map.resources :contexts

  
  map.rubyamf_gateway 'rubyamf_gateway', :controller => 'rubyamf', :action => 'gateway'
  
end
