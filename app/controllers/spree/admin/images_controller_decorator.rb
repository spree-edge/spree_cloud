module Spree
  module Admin::ImagesControllerDecorator
    def self.prepended(base)
      base.before_action :load_cloud_assets, only: [:new, :edit, :create, :update]
      base.before_action :set_cloud_asset, only: [:create, :update]
    end

    def load_cloud_assets
      @cloud_assets = current_store.cloud_assets
    end

    def set_cloud_asset
      if params[:cloud_asset_data].present?
        cloud_asset = Spree::CloudAsset.find_by(id: params[:cloud_asset_data])
        @image.attachment.attach(cloud_asset.attachment.blob)
      end
    end
  end
end

::Spree::Admin::ImagesController.prepend ::Spree::Admin::ImagesControllerDecorator