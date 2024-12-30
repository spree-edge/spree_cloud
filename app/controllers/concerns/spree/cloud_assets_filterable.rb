module Spree
  module CloudAssetsFilterable
    extend ActiveSupport::Concern

    included do
      before_action :load_cloud_assets, only: [:new, :edit, :create, :update, :filter_cloud_assets]
      before_action :load_filter_data, only: [:new, :edit, :create]
      before_action :set_cloud_asset, only: [:update, :create]
    end

    def set_cloud_asset
      if params[:cloud_asset].present? && params[resource.object_name][:attachment].nil?
        params[:cloud_asset].each do |attribute, cloud_asset_id|
          next if cloud_asset_id.blank?
          cloud_asset = ::Spree::CloudAsset.find_by(id: cloud_asset_id)
          if cloud_asset&.attachment&.attached?
            if @object.respond_to?(:attachment)
              @object.attachment = cloud_asset.attachment.blob
            elsif @object.respond_to?(attribute)
              image = @object.association(attribute).klass.new(viewable: @object)
              image.attachment.attach(cloud_asset.attachment.blob)
              image.save!
              @object.send("#{attribute}=", image)
            end
          end
        end
      end
    end

    def filter_cloud_assets
      if params.dig(:q, :created_at_eq).present?
        selected_date = Date.parse(params[:q][:created_at_eq])
        start_of_day = selected_date.beginning_of_day
        end_of_day = selected_date.end_of_day
        search_params = params[:q].except(:created_at_eq)
                                  .merge(created_at_gteq: start_of_day, created_at_lt: end_of_day)
        @search = @cloud_assets.ransack(search_params)
      else
        @search = @cloud_assets.ransack(params[:q])
      end

      @cloud_assets = @search.result(distinct: true)
      render turbo_stream: turbo_stream.replace("upload_asset_modal_body", partial: "spree/admin/images/cloud_assets_modal_body")
    end

    private

    def load_filter_data
      @search = @cloud_assets.ransack(params[:q])
    end

    def load_cloud_assets
      @cloud_assets = current_store.cloud_assets
    end
  end
end