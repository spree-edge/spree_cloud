module SpreeCloud
  module ApplicationControllerDecorator
    def self.prepended(base)
      base.before_action :set_custom_current_user
    end

    private

    def set_custom_current_user
      Thread.current["current_user_id"] = spree_current_user.try(:id)
      Thread.current["current_store_id"] = current_store.try(:id)
    end
  end
end

ApplicationController.prepend(SpreeCloud::ApplicationControllerDecorator)