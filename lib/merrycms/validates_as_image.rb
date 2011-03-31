module ValidatesAsImage

  def self.included receiver
    receiver.extend ClassMethods
  end

  module ClassMethods
    def validates_as_image fields

      validates_each fields do |record, attr, value|
        if !value.queued_for_write.empty? and value.to_file
          `identify "#{value.to_file.path}"`
          record.errors.add attr, I18n.t("activerecord.errors.models.#{record.class.table_name.singularize}.attributes.#{attr}.wrong_format") unless $? == 0
        end
      end
         
    end
  end
  
end