class UploadedFile
  include Mongoid::Document

  field :content
  validates_presence_of :content
end
