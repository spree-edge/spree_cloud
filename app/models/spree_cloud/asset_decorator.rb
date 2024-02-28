module SpreeCloud
  module AssetDecorator
    def self.prepended(base)
      base.after_save :create_cloud_asset
    end

    def create_cloud_asset
      cloud_asset_params = {
        asset_id: viewable_id,  
        asset_type: viewable_type,
        asset_url: '',
        asset_file_size: attachment.byte_size,
        attachment_content_type: attachment.content_type,
        asset_file_name: attachment.filename,
        alt: alt
      }

      begin
        cloud_asset = Spree::CloudAsset.new(cloud_asset_params)
        cloud_asset_attachment = self.attachment.blob
        cloud_asset.attachment.attach(cloud_asset_attachment)
        cloud_asset.save!
      rescue => e
        Rails.logger.error "Error creating cloud asset: #{e.message}"
      end
    end
  end
end
::Spree::Asset.prepend(SpreeCloud::AssetDecorator)
