module Spree
  module Admin
    class CloudsController < ResourceController
      before_action :load_filter_data, only: :index
      
      def index
        params[:q] ||= {}
        params[:q][:s] ||= 'created_at desc'

        if params[:q][:created_at_gt].present?
          params[:q][:created_at_gt] = begin
            Time.zone.parse(params[:q][:created_at_gt]).beginning_of_day
          rescue StandardError
            ''
          end
        end

        @search = @collection.ransack(params[:q])
        @collection = @search.result.
                      page(params[:page]).
                      per(params[:per_page] || Spree::Backend::Config[:admin_products_per_page])
      end

      def create
        @cloud_asset = Spree::CloudAsset.new(cloud_asset_params)
        @cloud_asset.store = current_store
        @cloud_asset.user = spree_current_user

        if @cloud_asset.save
          flash.now[:notice] = 'Cloud asset was successfully created.'
          render turbo_stream: turbo_stream.append('display-cloud-assets', partial: 'cloud_asset', locals: { cloud_asset: @cloud_asset })
        else
          render :index
        end
      end

      def destroy
        @cloud_asset = Spree::CloudAsset.find(params[:id])
        if @cloud_asset.destroy
          flash.now[:notice] = 'Cloud asset was successfully deleted.'
        else
          flash.now[:error] = 'Failed to delete cloud asset.'
        end
        redirect_to spree.admin_clouds_path
      end

      private

      def cloud_asset_params
        params.require(:cloud_asset).permit(:attachment, :asset_id, :asset_type, :asset_url, :asset_file_name, :alt)
      end

      def load_filter_data
        @content_type_options =  @collection.distinct.pluck(:attachment_content_type)
        @asset_type_options = @collection.distinct.pluck(:asset_type)
      end


      def model_class
        Spree::CloudAsset
      end
    end
  end
end

