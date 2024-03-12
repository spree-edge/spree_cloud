module ApplicationHelperDecorator
  def cloud_field_tag(name, options = {})
    cloud_assets = current_store.cloud_assets
    options = options.symbolize_keys if options.is_a?(Hash)

    content_tag :div, class: 'cloud-asset-container' do
      concat button_tag('Select Cloud Asset', type: 'button', class: 'cloud-asset-button', data: { toggle: 'modal', target: '#cloudAssetModal' })
      concat hidden_field_tag(name, nil, options)
      # concat file_field_tag(name, { class: 'cloud-asset-input', data: { toggle: 'modal', target: '#cloudAssetModal' } }.merge(options))
      concat render(partial: 'spree/admin/clouds/modal', locals: { cloud_assets: cloud_assets })
    end
  end
end

ApplicationHelper.prepend ApplicationHelperDecorator