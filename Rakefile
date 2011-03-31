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
    gemspec.add_dependency 'i18n-active_record'#, :git => 'git://github.com/svenfuchs/i18n-active_record.git', :require => 'i18n/active_record'
    gemspec.add_dependency 'jquery-rails', '>= 0.2.6'
    gemspec.add_dependency 'kaminari'
    gemspec.add_dependency 'meta_search'
    gemspec.add_dependency 'paperclip'
    gemspec.add_dependency 'open4'
    gemspec.add_dependency 'newbamboo-rvideo'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler -s http://gemcutter.org"
end
