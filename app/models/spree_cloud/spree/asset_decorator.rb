module SpreeCloud
  module Spree
    module AssetDecorator
      def self.prepended(base)
        base.after_commit :create_cloud_asset, unless: -> { cloud_asset_exists? }
      end

      def create_cloud_asset
        CreateCloudAssetJob.perform_later(self, cloud_asset_params) if self.attachment.attached?
      end

      private

      def cloud_asset_exists?
        attachment_blob_checksum = self.attachment.blob.checksum
        ::Spree::CloudAsset.joins({attachment_attachment: :blob }).where(active_storage_blobs: { checksum: attachment_blob_checksum }).exists?
      end

      def cloud_asset_params
        {
          asset_id: viewable_id,  
          asset_type: viewable_type,
          asset_url: '',
          alt: alt,
          store_id: Thread.current["#{Apartment::Tenant.current}_current_store_id"],
          user_id: Thread.current["#{Apartment::Tenant.current}_current_user_id"]
        }
      end
    end
  end
end

::Spree::Asset.prepend(::SpreeCloud::Spree::AssetDecorator)
