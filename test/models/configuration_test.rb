require 'test_helper'

class ConfigurationTest < ActiveSupport::TestCase
  test 'string value is correct' do
    assert_equal 'MyString', Configuration.string_config
  end
  
  test 'string value is String type' do
    assert_equal String, Configuration.string_config.class
  end
  
  test 'true boolean value is correct' do
    assert_equal true, Configuration.boolean_true_config
  end
  
  test 'false boolean value is correct' do
    assert_equal false, Configuration.boolean_false_config
  end
  
  test 'boolean value is a boolean type' do
    assert_equal TrueClass, Configuration.boolean_true_config.class
  end
  
  test 'float value is correct' do
    assert_equal 3.5, Configuration.float_config
  end
  
  test 'float value is Float type' do
    assert_equal Float, Configuration.float_config.class
  end
  
  test 'integer value is correct' do 
    assert_equal 3, Configuration.integer_config
  end
  
  test 'integer value is Fixnum type' do
    assert_equal Configuration.integer_config.class, Fixnum
  end
  
  test 'able to change string config value' do
    Configuration.string_config_to_set = 'TestString'
    assert_equal 'TestString', Configuration.string_config_to_set
  end
  
  test 'able to change boolean config value' do 
    Configuration.boolean_true_config_to_set = false
    assert_equal false, Configuration.boolean_true_config_to_set
  end
  
  test 'able to change float config value' do
    Configuration.float_config_to_set = 4.5
    assert_equal 4.5, Configuration.float_config_to_set
  end
  
  test 'able to change integer config value' do
    Configuration.integer_config_to_set = 4
    assert_equal 4, Configuration.integer_config_to_set
  end
 
  test 'new value is used after setting it' do
    new_value = Configuration.cache_test + " change"
    Configuration.cache_test = new_value
    assert_equal new_value, Configuration.cache_test
  end
  
  test 'getter works after a create' do
    new_config = Configuration.new(name: 'new_config_get_test', 
                 value: 'hello', value_type: 'string')
    new_config.save!
    assert_equal 'hello', Configuration.new_config_get_test
  end
  
  test 'setter works after a create' do
    new_config = Configuration.new(name: 'new_config_set_test', 
      value: 'hello', value_type: 'string')
    new_config.save!
    Configuration.new_config_set_test = 'goodbye'
    assert_equal 'goodbye', Configuration.new_config_set_test
  end
end
