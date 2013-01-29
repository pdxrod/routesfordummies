require File.expand_path('../../test_helper', __FILE__)

class GetTest < ActionDispatch::IntegrationTest 

  def test_should_try_to_get_abcdeg_path_with_optional_parameters_if_optional_set

    if ENV[ 'OPTIONAL_PARAMETERS' ].to_s.strip != '1'
      puts "\n#{ File.basename $0 }: Set environment variable OPTIONAL_PARAMETERS to 1 to run test for routes like this: controller/(:a)/(:b)/(:c) etc."
    else

      Rockonruby::Application.routes.prepend do 
        get OPTIONAL_ROUTES => 'new#an_action'
      end
      Rockonruby::Application.reload_routes!

      puts
      t = Time.now 
      puts "Started at #{t}"
      get ABCDEG_PATH 
      assert_response :success
      s = Time.now
      puts "Finished at #{s}"
      u = ((s - t) / 60.0).to_s 
      puts "\n#{ File.basename $0 }: Took #{ u[ 0 .. (u.index( '.' ) + 1) ] } minutes" 

    end

  end

end


