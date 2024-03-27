module SpreeCloud
  module ApplicationControllerDecorator
    def self.prepended(base)
      base.before_action :set_custom_current_user
    end

    private

    def set_custom_current_user
      Thread.current["#{Apartment::Tenant.current}_current_user_id"] = spree_current_user.try(:id)
    end
  end
end

ApplicationController.prepend(SpreeCloud::ApplicationControllerDecorator)