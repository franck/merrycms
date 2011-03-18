class Translation < ActiveRecord::Base
  
  cattr_accessor :locales_config_path
  self.locales_config_path = "#{Rails.root}/config/locales"
  
  scope :pending, where('value is null')
  scope :not_pending, where('value is not null')
  scope :search_query, lambda {|query| where("key LIKE ? OR value LIKE ?", "%#{query}%", "%#{query}%") }

  # create one yml per locale
  def self.dump_all(to = self.locales_config_path)
    I18n.available_locales.each do |locale|
      File.open("#{to}/#{locale}.yml", "w+") do |file|
        hash = to_hash(locale)
        hash = { locale.to_s => {} }if hash.size == 0
        YAML.dump(hash, file)
      end
    end
  end
  
  protected
  
  def self.to_hash(locale)
    hash = {}
    translations = self.where(:locale => locale).where("value not null")
    translations.each do |translation|
      if translation.key.include?(".")
        hash.deep_merge!(locale.to_s => unsquish(translation.key, translation.value))
      else
        hash.merge!(locale.to_s => { translation.key => translation.value }) 
      end
    end
    hash
  end
    
  def self.unsquish(string, value)
    if string.is_a?(String)
      unsquish(string.split("."), value)
    elsif string.size == 1
      { string.first => value }
    else
      key  = string[0]
      rest = string[1..-1]
      { key => unsquish(rest, value) }
    end
  end
  
end
