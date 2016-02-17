Rails.application.routes.draw do

  get 'remove_students/index'

  get 'remove_students/destroy'

  post 'enrollments/create'
  delete 'enrollments/destroy'
  get '/enrollments/index'
  put '/enrollments/update' => 'enrollments#update'
  get '/enrollments/create'

  get '/grades/edit' => 'grades#edit'
  get '/grades/students_list' => 'grades#students_list'
  post '/grades/edit' => 'grades#edit'
  patch '/grades/update' => 'grades#update'

  get '/coursepage_materials/index'
  get '/coursepage_materials/new'
  get '/coursepage_materials/create'
  post '/coursepage_materials/create' => 'coursepage_materials#create'
  get 'materials/new'
  get 'materials/create'
  get 'materials/index'

  get '/students/show' =>   'students#show'
  get '/students/search'  => 'students#search'
  get '/students/course_info' => 'students#course_info'
  post '/students/search_submit' => 'students#search_submit'
  get '/students/search_submit' => 'students#search'
  get '/students/course_history' => 'students#course_history'
  get '/students/course_notification' => 'students#course_notification'

  get '/courses/list_courses' => 'courses#list_courses'
  get '/courses/content' => 'courses#content'

  resources :students, only: [:new, :create, :edit, :update, :show]
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

  get '/admins/manage_admin/view_admin/:id'=> 'admins#view_admin', as: :view_admin
  post 'admins/create_admin' => 'admins#create'
  get '/admins/manage_admin/edit_admin' => 'admins#edit_admin'
  patch 'admins/edit_admin_save' => 'admins#edit_admin_save'
  get '/admins/create_instructor' => 'admins#create_instructor'
  post '/admins/create_instructor_save' =>'admins#create_instructor_save'
  get '/admins/manage_course/view_course/:id' => 'admins#view_course', as: :view_course
  get '/admins/manage_course/delete_course/:id' => 'admins#delete_course', as: :delete_course
  get '/admins/manage_course/create_course' => 'admins#create_course'
  post '/admins/manage_course/create_course_save' => 'admins#create_course_save'
  get '/admins/manage_course/edit_course/:id' => 'admins#edit_course', as: :edit_admin_course
  patch '/admins/edit_admin_course_save/:id' => 'admins#edit_admin_course_save'
  get '/admins/create_student' => 'admins#create_student'
  post '/admins/create_student_save' =>'admins#create_student_save'

  get '/admins/admin_view_student/:id' => 'admins#admin_view_student',as: :view_student
  get '/admins/view_instructor/:id' => 'admins#view_instructor',as: :view_instructor

  get 'messages/see_message' => 'messages#see_message',as: :see_message
  post 'messages/send_new_message' => 'messages#send_new_message',as: :send_new_message


  get 'messages/instructor_message_view/:id' => 'messages#instructor_message_view',as: :instructor_message_view
  get 'messages/instructor_message_send/:id' => 'messages#instructor_message_send',as: :instructor_message_send

  post 'messages/instructor_message_save' => 'messages#instructor_message_save',as: :instructor_message_save


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
