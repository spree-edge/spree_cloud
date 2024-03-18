module Spree
  class CloudAsset < Spree::Base
    validates :attachment, attached: true
    

    has_one_attached :attachment
    before_save :add_cloud_asset_data


    belongs_to :store
    belongs_to :user, class_name: 'Spree::User', foreign_key: 'user_id'

    # self.whitelisted_ransackable_associations = %w[conversations]
    self.whitelisted_ransackable_attributes = %w[created_at email attachment_content_type asset_type asset_file_name user_name]
    self.whitelisted_ransackable_associations = %w[user]


    private

    def add_cloud_asset_data
      if attachment.attached?
        self.asset_file_name = attachment.filename.to_s
        self.asset_file_size = attachment.byte_size
        self.attachment_content_type = attachment.content_type
      end
    end
  end
end
