module Spree
  module Admin
    class CloudsController < ResourceController
      
      def index
        @cloud_assets = Spree::CloudAsset.all
      end

      # def new
      #   @cloud_asset = Spree::CloudAsset.new
      # end

      def create
        @cloud_asset = Spree::CloudAsset.new(cloud_asset_params)

        if @cloud_asset.save
          flash.now[:notice] = 'Cloud asset was successfully created.'
          render turbo_stream: turbo_stream.append('cloud_assets', partial: 'cloud_asset', locals: { cloud_asset: @cloud_asset })
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
        params.require(:cloud_asset).permit(:attachment)
      end

      def collection
        return @collection if @collection.present?

        params[:q] ||= {}
        params[:q][:s] ||= 'created_at asc'

        @collection = cloud_asset_scope

        @search = @collection.ransack(params[:q])
        @collection = @search.result.
                      page(params[:page]).
                      per(params[:per_page] || Spree::Backend::Config[:admin_products_per_page])

        @collection
      end

      def cloud_asset_scope
        current_store.cloud_assets.accessible_by(current_ability, :index)
      end
    end
  end
end

