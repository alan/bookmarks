module Bitly
  Config = YAML.load_file(RAILS_ROOT + '/config/bitly.yml')[Rails.env.to_s].symbolize_keys
end