module SpreeCloud
  module Spree
    module StoreDecorator
      def self.prepended(base)
        base.has_many :cloud_assets
      end
    end
  end
end

::Spree::Store.prepend ::SpreeCloud::Spree::StoreDecorator
