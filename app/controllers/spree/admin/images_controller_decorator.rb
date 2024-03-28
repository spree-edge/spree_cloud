module Spree
  module Admin::ImagesControllerDecorator
    def self.prepended(base)
      base.before_action :load_cloud_assets, only: [:new, :edit, :create, :update, :filter_cloud_assets]
      base.before_action :load_filter_data, only: :edit
    end

    def update
      invoke_callbacks(:update, :before)
      set_cloud_asset if params[:image][:attachment].nil?
      if @object.update(permitted_resource_params)
        set_current_store
        invoke_callbacks(:update, :after)
        respond_with(@object) do |format|
          format.turbo_stream if update_turbo_stream_enabled?
          format.html do
            flash[:success] = flash_message_for(@object, :successfully_updated)
            redirect_to location_after_save unless request.xhr?
          end
          format.js { render layout: false }
        end
      else
        invoke_callbacks(:update, :fails)
        respond_with(@object) do |format|
          format.html { render action: :edit, status: :unprocessable_entity }
          format.js { render layout: false, status: :unprocessable_entity }
        end
      end
    end

    def set_cloud_asset
      if params[:cloud_asset_data].present? && params[:image][:attachment].nil?
        cloud_asset = Spree::CloudAsset.find_by(id: params[:cloud_asset_data])
        @image.attachment = cloud_asset.attachment.blob if cloud_asset.attachment.attached?
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

      render turbo_stream: turbo_stream.replace("upload_asset_modal_body", partial: "cloud_assets_modal_body")
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

::Spree::Admin::ImagesController.prepend ::Spree::Admin::ImagesControllerDecorator