#if RAILS_ENV == 'development' || RAILS_ENV == 'test' || RAILS_ENV == 'production'
if Rails.env == 'development' || Rails.env == 'test'
  Paperclip.options[:command_path] = "/opt/local/bin/"
else
  Paperclip.options[:command_path] = "/usr/local/bin/"
end
