class Spree::CloudAsset < ActiveRecord::Base
  before_save :add_cloud_asset_data

  has_one_attached :attachment

  validates :attachment, attached: true

  private

  def add_cloud_asset_data
    if attachment.attached?
      self.asset_file_name = attachment.filename.to_s
      self.asset_file_size = attachment.byte_size
      self.attachment_content_type = attachment.content_type
    end
  end
end
