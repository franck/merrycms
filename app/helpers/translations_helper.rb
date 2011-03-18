module TranslationsHelper
  
  def display_available_locales
    I18n.available_locales.map{|locale| t("translations.locales.#{locale}") }.join(", ")
  end
  
  def display_translation_if_exist(translation)
    other_locales = I18n.available_locales - [translation[:locale].to_sym]
    other_locale = other_locales.first
    if other_locale
      other_translation = Translation.find_by_key_and_locale(translation[:key], other_locale)
      if other_translation
        html = "<p>#{other_translation.value}</p>"
      else
        html = "<p class='no_translation'>#{t('translations.no_translation')}</p>"
      end
    else
      html = "<p class='no_translation'>#{t('translations.no_translation')}</p>"
    end
    raw html
  end
  

end