module SpreeCloud
  class CreateCloudAssetJob < ActiveJob::Base
    queue_as :default

    def perform(asset, cloud_asset_params)
      return unless asset

      attachment_params = {
        asset_file_size: asset.attachment.byte_size,
        attachment_content_type: asset.attachment.content_type,
        asset_file_name: asset.attachment.filename
      }

      all_params = cloud_asset_params.merge(attachment_params)

      begin
        cloud_asset = ::Spree::CloudAsset.new(all_params)

        cloud_asset_attachment = asset.attachment.blob
        cloud_asset.attachment.attach(cloud_asset_attachment)
        cloud_asset.save!
      rescue => e
        Rails.logger.error "Error creating cloud asset: #{e.message}"
      end
    end
  end
end