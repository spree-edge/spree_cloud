$(document).on('turbo:load', function () {
  $('#associate_asset_modal').on('click', '.asset-area', function() {
    $('#cloud_asset_id_field').val($(this).find('.attachment').attr('data-id'));
    $('#cloud_asset_file_name').val($(this).find('.attachment').attr('data-name'));
    $(this).siblings().removeClass('active');
    $(this).addClass('active');
  });

  $('#associate_asset_modal').on('dblclick', '.asset-area', function() {
    $('#cloud_asset_id_field').val($(this).find('.attachment').attr('data-id'));
    $('#cloud_asset_file_name').val($(this).find('.attachment').attr('data-name'));
    $('.close').click();
  });

  $(".attach-btn").on('click', function() {
    $('.close').click();
  })
});
