module Spree
  module Admin
    class CloudsController < ResourceController
      
      def index
        params[:q] ||= {}
        params[:q][:s] ||= 'created_at asc'

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


      def model_class
        Spree::CloudAsset
      end
    end
  end
end

