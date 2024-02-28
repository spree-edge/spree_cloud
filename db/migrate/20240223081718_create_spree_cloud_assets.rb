class CreateSpreeCloudAssets < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_cloud_assets do |t|
      t.bigint :asset_id
      t.string :asset_type
      t.string :asset_url
      t.integer :asset_file_size
      t.integer :attachment_content_type
      t.string :asset_file_name
      t.text :alt

      t.timestamps
    end
  end
end

