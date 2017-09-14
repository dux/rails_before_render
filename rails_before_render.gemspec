Gem::Specification.new do |gem|
  gem.name        = 'rails_before_render'
  gem.version     = File.read('./.version')
  gem.summary     = 'Missing Ruby on Rails before_render controller filter'
  gem.description = 'Just as before_filter in controllers, this one will be executed just before render occurs.'
  gem.authors     = ["Dino Reic"]
  gem.email       = 'reic.dino@gmail.com'
  gem.files       = Dir['./lib/**/*.rb']+['./.version']
  gem.homepage    = 'https://github.com/dux/rails_before_render_filter'
  gem.license     = 'MIT'

  gem.add_runtime_dependency 'fast_blank', '~> 1'
end