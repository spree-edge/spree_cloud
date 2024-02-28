Deface::Override.new(virtual_path: 'spree/admin/images/_form',
  name: 'add_asset_from_cloud_to_image_form',
  replace: "[data-hook='file']",
  partial: 'spree/admin/shared/upload_cloud_asset',
)
