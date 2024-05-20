module Spree
  module Admin
    class CloudsController < ResourceController
      before_action :load_filter_data, only: :index
      
      def index
        params[:q] ||= {}
        params[:q][:s] ||= 'created_at desc'

        if params.dig(:q, :created_at_eq).present?
          selected_date = Date.parse(params[:q][:created_at_eq])
          start_of_day = selected_date.beginning_of_day
          end_of_day = selected_date.end_of_day
          search_params = params[:q].except(:created_at_eq)
                            .merge(created_at_gteq: start_of_day, created_at_lt: end_of_day)
          @search = @collection.ransack(search_params)
        else
          @search = @collection.ransack(params[:q])
        end

        @collection = @search.result.
                      page(params[:page]).
                      per(params[:per_page] || Spree::Backend::Config[:admin_products_per_page])
      end

      def create
        @cloud_asset = Spree::CloudAsset.new(cloud_asset_params)
        @cloud_asset.store = current_store
        @cloud_asset.user = spree_current_user

        if @cloud_asset.save
          flash[:success] = 'Cloud asset was successfully created.'
          # render turbo_stream: turbo_stream.replace('display-cloud-assets', partial: 'cloud_asset_table', locals: { collection: collection })
          redirect_to spree.admin_clouds_path
        else
          render :index
        end
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

