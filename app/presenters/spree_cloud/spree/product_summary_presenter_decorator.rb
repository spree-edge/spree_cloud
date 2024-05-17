module SpreeCloud
  module Spree
    module ProductSummaryPresenterDecorator
      private

      def images
        @product.images.map do |image|
          {
            url_product: cdn_image_url(image.attachment, only_path: true)
          }
        end
      rescue 
        {}
      end
    end
  end
end

::Spree::ProductSummaryPresenter.prepend(SpreeCloud::Spree::ProductSummaryPresenterDecorator)