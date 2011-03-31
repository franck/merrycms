module Admin
  module ImagesHelper
  
    def display_image_links(image)
      html = ""
      html << "<strong>#{t('images.styles.original')}</strong> : #{image.image.url(:original, false)}<br/>"
      image.image.styles.each do |style, file|
        html << "<strong>#{t("images.styles.#{style}")}</strong> : #{image.image.url(style, false)}<br/>"
      end
      html
    end
  
  end
end