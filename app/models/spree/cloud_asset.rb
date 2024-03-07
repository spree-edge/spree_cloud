module Spree
  class CloudAsset < Spree::Base
    validates :attachment, attached: true

    has_one_attached :attachment

    belongs_to :store
    belongs_to :user, class_name: 'Spree::User', foreign_key: 'user_id'

    # self.whitelisted_ransackable_associations = %w[conversations]
    self.whitelisted_ransackable_attributes = %w[created_at email attachment_content_type asset_file_name user_name]
  end
end
