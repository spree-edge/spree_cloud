module SpreeCloud
  module Spree
    module Admin::ImagesControllerDecorator
      def self.prepended(base)
        base.include ::Spree::CloudAssetsFilterable
      end
    end
  end
end

::Spree::Admin::ImagesController.prepend ::SpreeCloud::Spree::Admin::ImagesControllerDecorator