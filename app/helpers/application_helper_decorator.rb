module ApplicationHelperDecorator
  def cloud_asset_upload_button(button_text: 'Upload From Cloud',
                                modal_target: '#associate_asset_modal',
                                input_id:,
                                hidden_field_name:,
                                input_field_id:,
                                button_class: 'upload_asset_button')
    content_tag(:div, class: 'cloud-asset-upload') do
      content_tag(:span, class: 'input-group-btn') do
        button_tag(type: 'button',
                   class: "btn btn-primary mt-3 #{button_class}",
                   data: { toggle: 'modal', target: modal_target, input_id: input_id, input_field_id:  }) do
          button_text
        end
      end +
      text_field_tag(nil, nil, id: input_id,
                           disabled: true,
                           class: 'col-12 mt-3 form-control') +
      hidden_field_tag(hidden_field_name, nil, id: "#{hidden_field_name}_hidden")
    end
  end
end
ApplicationHelper.prepend ApplicationHelperDecorator