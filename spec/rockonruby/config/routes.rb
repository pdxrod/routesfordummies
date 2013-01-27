Rockonruby::Application.routes.draw do 
  
   root :to => 'main#index'  
                            
# How to expand this to cover all possible URLs with up to 5 /'s and an optional parameters list after the ?                                                                                                                               
  get 'old/:version/:scope'               => 'old#an_action'                  
  get 'old/:version/:media/:id/:scope'      => 'old#an_action'     
  get 'old/:version/:scope/:id/media.:format' => 'old#an_action'

# /new/foo/bar/fubar/ /new/foo/bar/fubar/snafu /new/foo etc.                                                  
  get 'new/(:a)/(:b)/(:c)/(:d)/(:e)/(:f)/(:g)/(:h)/(:i)/(:j)/(:k)/(:l)/(:m)/(:n)/(:o)/(:p)/(:q)/(:r)/(:s)/(:t)/(:u)/(:v)/(:w)/(:x)/(:y)' => 'new#an_action'
                                       
#   get '/:controller(/:action(/:id))'  

end



