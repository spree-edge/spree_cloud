class Spree::CloudAsset < ActiveRecord::Base
  has_one_attached :attachment

  validates :attachment, attached: true
end
