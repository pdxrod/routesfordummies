#!/bin/sh

ruby ./test/integration/get_test.rb
ruby ./test/integration/url_test.rb
ruby ./test/integration/restful_verb_test.rb	
rake spec

