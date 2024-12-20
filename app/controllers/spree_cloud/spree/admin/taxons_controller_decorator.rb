module SpreeCloud
  module Spree
    module Admin
      module TaxonsControllerDecorator
        def self.prepended(base)
          base.include ::Spree::CloudAssetsFilterable
        end
      end
    end
  end
end

::Spree::Admin::TaxonsController.prepend ::SpreeCloud::Spree::Admin::TaxonsControllerDecorator
