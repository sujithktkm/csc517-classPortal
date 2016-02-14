Rails.application.routes.draw do

  get 'enrollments/index'
  get 'enrollments/new'
  get 'enrollments/create'
  get 'grades/index'
  get 'grades/new'
  get 'grades/create'

  get '/coursepage_materials/index'
  get '/coursepage_materials/new'
  get '/coursepage_materials/create'
  post '/coursepage_materials/create' => 'coursepage_materials#create'
  get 'materials/new'
  get 'materials/create'
  get 'materials/index'

  #get 'students/new'
  get 'students/search'  => 'students#search'
  post '/students/search_submit' => 'students#search_submit'
  #get 'students/:id/edit' => 'students#edit'
  #post 'students/:id' => 'students#update'
  # get 'student/new'
  # get 'student/create'

  get '/courses/list_courses' => 'courses#list_courses'
  get '/courses/content' => 'courses#content'

  resources :students, only: [:new, :create, :edit, :update]
  resources :courses


  root 'welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  get '/login' => 'authentications#new'
  post '/login' => 'authentications#create'
  delete '/logout' => 'authentications#destroy'

  get '/admins/manage_admin' => 'admins#manage_admin'
  get '/admins/manage_course' => 'admins#manage_course'
  get '/admins/manage_user' => 'admins#manage_user'
  get '/admins/manage_admin/delete/:id' => 'admins#delete_admin', as: :delete_admin
  get '/admins/manage_user/delete/:id' => 'admins#delete_user', as: :delete_user
  get '/admins/manage_admin/create_admin' => 'admins#create_admin'
  get '/admins/manage_admin/view_admin/:id' => 'admins#view_admin', as: :view_admin
  #post 'admins/manage_admin/create_admin' => 'admin#create'
  resources :admins

  # get 'signup' => ''

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admins do
  #     # Directs /admins/products/* to Admin::ProductsController
  #     # (app/controllers/admins/products_controller.rb)
  #     resources :products
  #   end
end
