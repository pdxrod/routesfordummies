require File.expand_path('../../test_helper', __FILE__)

class GetTest < ActionDispatch::IntegrationTest 

  def test_should_try_to_get_abcdeg_path_with_optional_parameters_if_optional_set

    if ENV[ 'OPTIONAL_PARAMETERS' ].to_s.strip != '1'
      puts "\nSet environment variable OPTIONAL_PARAMETERS to 1 to run test for routes like this: controller/(:a)/(:b)/(:c) etc."
    else

      Rockonruby::Application.routes.prepend do 
        get OPTIONAL_ROUTES => 'new#an_action'
      end
      Rockonruby::Application.reload_routes!

      get ABCDEG_PATH
    end

  end

end



