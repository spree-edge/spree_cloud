module SpreeCloud
  module Spree
    module VariantPresenterDecorator
      def images(variant)
        variant.images.map do |image|
          {
            alt: image.alt,
            url_product: image.attachment.blob.variable? ? rails_representation_url(image.url(:product), only_path: true) : cdn_image_url(image.attachment, only_path: true)
          }
        end
      end
    end
  end
end

::Spree::VariantPresenter.prepend(SpreeCloud::Spree::VariantPresenterDecorator)
