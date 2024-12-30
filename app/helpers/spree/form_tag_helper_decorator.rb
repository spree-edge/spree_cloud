# app/helpers/spree/custom_form_builder.rb
module Spree::FormTagHelperDecorator
  def cloud_upload(form, button_text: 'Upload From Cloud', input_id: 'cloud_asset_file_name', modal_target: '#associate_asset_modal')
    content_tag(:div, class: 'row form-group m-2') do
      concat content_tag(:span, class: 'input-group-btn', id: 'asset_upload_button') {
        button_tag(type: 'button', class: 'btn btn-primary mt-3', id: 'upload_asset_button', data: { toggle: 'modal', target: modal_target }) do
          button_text
        end
      }
      concat content_tag(:span) {
        form.text_field(nil, disabled: true, id: input_id, class: 'col-12 mt-3 form-control')
      }
    end
  end
end
ActionView::Helpers::FormTagHelper.prepend Spree::FormTagHelperDecorator
