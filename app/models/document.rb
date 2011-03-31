class Document < ActiveRecord::Base
  
  has_attached_file :doc
  validates_attachment_presence :doc, :message => I18n.t('activerecord.errors.models.document.attributes.doc.blank')
  validates_presence_of :title
  
end
