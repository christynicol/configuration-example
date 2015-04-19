class Configuration < ActiveRecord::Base
  validates :name, presence: true,
            uniqueness: true
  validates :value, presence: true
  validates :value_type, inclusion: { in: ['string', 'integer', 'float', 'boolean'] }
  
  CACHE_KEY_PREFIX = "configuration"
  
  def self.create_config_getter(config_name, type_conversion)
    define_singleton_method(config_name) do
      return Rails.cache.fetch("#{CACHE_KEY_PREFIX}_#{config_name}", expires_in: 1.hour, race_condition_ttl: 1) do 
        to_get = Configuration.find_by name: config_name
        if (type_conversion)
          to_get.value.send(type_conversion)
        else
          to_get.value
        end
      end
    end
  end
  
  def self.create_config_methods(config)
    case config.value_type
    when 'string'
      create_config_getter(config.name, nil)
    when 'integer'
      create_config_getter(config.name, :to_i)
    when 'boolean'
      create_config_getter(config.name, :to_b)
    when 'float' 
      create_config_getter(config.name, :to_f)
    end
    define_singleton_method("#{config.name}=") do |new_value|
      to_set = Configuration.find_by name: config.name
      to_set.value = new_value
      to_set.save!
      Rails.cache.delete("#{CACHE_KEY_PREFIX}_#{to_set.name}")
      new_value
    end
  end
  
  after_create do
    Configuration.create_config_methods(self)
  end
  
  configs = Configuration.all
  configs.each do |config|
    create_config_methods(config)
  end
end
