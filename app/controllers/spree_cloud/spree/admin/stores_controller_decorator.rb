module SpreeCloud
  module Spree
    module Admin
      module StoresControllerDecorator
        def self.prepended(base)
          base.include ::Spree::CloudAssetsFilterable
        end

        def set_cloud_asset
          if params[:cloud_asset].present? && params[:store][:attachment].nil?
            params[:cloud_asset].each do |attribute, cloud_asset_id|
              next if cloud_asset_id.blank?

              cloud_asset = ::Spree::CloudAsset.find_by(id: cloud_asset_id)

              if cloud_asset&.attachment&.attached?
                if @store.respond_to?(:attachment)
                  @store.attachment = cloud_asset.attachment.blob
                elsif @store.respond_to?(attribute)
                  image = @store.association(attribute).klass.new(viewable: @store)
                  image.attachment.attach(cloud_asset.attachment.blob)
                  image.save!
                  @store.send("#{attribute}=", image)
                end
              end
            end
          end
        end
      end
    end
  end
end

::Spree::Admin::StoresController.prepend ::SpreeCloud::Spree::Admin::StoresControllerDecorator
