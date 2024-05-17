Deface::Override.new(
  virtual_path: 'spree/admin/shared/_main_menu',
  name: 'add_cloud_tab',
  insert_after: 'ul#sidebarPromotion',
  text: <<-HTML
    <% if can? :admin, Spree::CloudAsset %>
      <ul class="nav nav-sidebar" id="sidebarCloud">
        <%= tab 'Cloud', url: admin_clouds_path, match_path: '/clouds', icon: "cloud.svg" %>
      </ul>
    <% end %>
  HTML
)
