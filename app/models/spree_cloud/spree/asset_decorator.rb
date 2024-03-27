module SpreeCloud
  module Spree
    module AssetDecorator
      def self.prepended(base)
        base.after_save :create_cloud_asset, unless: -> { cloud_asset_exists? }
      end

      def create_cloud_asset
        begin
          cloud_asset = ::Spree::CloudAsset.new(cloud_asset_params)
          cloud_asset_attachment = self.attachment.blob
          cloud_asset.attachment.attach(cloud_asset_attachment)
          cloud_asset.save!
        rescue => e
          Rails.logger.error "Error creating cloud asset: #{e.message}"
        end
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
          asset_file_size: attachment.byte_size,
          attachment_content_type: attachment.content_type,
          asset_file_name: attachment.filename,
          alt: alt,
          store_id: Thread.current["#{Apartment::Tenant.current}_current_store_id"],
          user_id: Thread.current["#{Apartment::Tenant.current}_current_user_id"]
        }
      end
    end
  end
end

::Spree::Asset.prepend(::SpreeCloud::Spree::AssetDecorator)
