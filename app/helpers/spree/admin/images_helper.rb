module Spree
  module Admin
    module ImagesHelper
      def options_text_for(image)
        if image.viewable.is_a?(Spree::Variant)
          if image.viewable.is_master?
            Spree.t(:all)
          else
            image.viewable.sku_and_options_text
          end
        else
          Spree.t(:all)
        end
      end

      def display_attachment(image)
        main_app.url_for(image.attachment)
      end

      def image?
        content_type.start_with?("image")
      end
    end
  end
end
