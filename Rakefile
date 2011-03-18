begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "merrycms"
    gemspec.summary = "Admin panel for rails3 app : user management, pages, categories"
    gemspec.description = "Admin panel for rails3 app : user management, pages, categories"
    gemspec.email = "franck.dagostini@gmail.com"
    gemspec.homepage = "https://github.com/franck/merrycms"
    gemspec.authors = ["Franck D'agostini"]
    gemspec.files = Dir["{lib}/**/*", "{app}/**/*", "{config}/**/*"]
    gemspec.add_dependency 'devise', '>= 1.1.7'
    gemspec.add_dependency 'acl9'
    gemspec.add_dependency 'RedCloth'
    gemspec.add_dependency 'friendly_id'
    gemspec.add_dependency 'transitions'
    gemspec.add_dependency 'nested_set'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler -s http://gemcutter.org"
end
