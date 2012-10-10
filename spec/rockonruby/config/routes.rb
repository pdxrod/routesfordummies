Rockonruby::Application.routes.draw do 
  
   root :to => 'main#index'  
                            
# How to expand this to cover all possible URLs with up to 5 /'s and an optional parameters list after the ?                                                                                                                               
   get 'old/:version/:scope'               => 'old#an_action'                  
   get 'old/:version/:object/:id/:scope'     => 'old#an_action'     
   get 'old/:version/:scope/:id/media.:format' => 'old#an_action'

# /new/foo/bar/fubar/ /new/foo/bar/fubar/snafu /new/foo etc.                                                  
   get 'new/:a'        => 'new#an_action'
   get 'new/:a/:b'        => 'new#an_action'
   get 'new/:a/:b/:c'        => 'new#an_action'
   get 'new/:a/:b/:c/:d'        => 'new#an_action'
   get 'new/:a/:b/:c/:d/:e'        => 'new#an_action'   
                                       
#   get '/:controller(/:action(/:id))'  

end



