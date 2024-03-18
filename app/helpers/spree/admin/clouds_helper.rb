module Spree::Admin::CloudsHelper
  def display_asset_image(cloud_asset)
    image_tag Rails.application.routes.url_helpers.rails_blob_url(cloud_asset.attachment)
  end

  def display_asset_type(cloud_asset)
    "<td>#{cloud_asset.asset_file_name}<br>
      <span>#{cloud_asset.attachment.content_type.split("/").last.upcase}</span>
      <span class='badge badge-secondary'>#{cloud_asset.asset_type&.split("::")&.last}</span>
    </td>".html_safe
  end

  def display_asset_actions(cloud_asset)
    actions = ""
    actions += link_to_edit(cloud_asset, class: '', no_text: true) if can?(:edit, cloud_asset)
    actions += link_to_delete(cloud_asset, no_text: true) if can?(:delete, cloud_asset)
    "<td class='actions'><span class='d-flex justify-content-end'>#{actions}</span></td>".html_safe
  end

  def file_size_in_kb(file_size)
    (file_size.to_f / 1024).round(2)
  end
end
