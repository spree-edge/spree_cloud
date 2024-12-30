Rails.application.config.after_initialize do
  if Spree::Core::Engine.backend_available?
    Rails.application.config.spree_backend.main_menu.add(
      ::Spree::Admin::MainMenu::ItemBuilder.new(
        'Cloud',
        ::Spree::Core::Engine.routes.url_helpers.admin_clouds_path
      )
      .with_icon_key('cloud.svg')
      .with_manage_ability_check(Spree::CloudAsset)
      .with_match_path('/clouds')
      .build
    )
  end
end