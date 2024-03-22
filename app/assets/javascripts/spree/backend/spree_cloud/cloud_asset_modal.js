$(document).ready(function() {
  $('#associate_asset_modal').on('click', '.asset-area', function() {
    $('#cloud_asset_id_field').val($(this).find('.attachment').attr('data-id'));
    $('#cloud_asset_file_name').val($(this).find('.attachment').attr('data-name'));
  });

  $('#associate_asset_modal').on('dblclick', '.asset-area', function() {
    $('#associate_asset_modal').modal('hide');
  });

  $(".attach-btn").on('click', function() {
    $('#associate_asset_modal').modal('hide');
  })
});
