module Spree
  module Admin
    class CloudsController < Spree::Admin::BaseController
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

      def update
        @cloud_asset = Spree::CloudAsset.find(params[:id])
        if @cloud_asset.update(cloud_asset_params)
          flash[:success] = "Cloud asset updated successfully"
          redirect_to admin_clouds_path
        else
          flash[:error] = "Failed to update cloud asset"
          render :edit
        end
      end

      def edit
        @cloud_asset = Spree::CloudAsset.find(params[:id])
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
    end
  end
end

