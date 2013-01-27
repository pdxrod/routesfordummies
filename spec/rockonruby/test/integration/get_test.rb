require File.expand_path('../../test_helper', __FILE__)

class GetTest < ActionDispatch::IntegrationTest 

  def test_should_try_to_get_abcdeg_path
    get ABCDEG_PATH
  end

end



