$(document).on('turbo:load', function () {
  const attachmentField = $('#image_attachment');
  const cloudAssetIdField = $('#cloud_asset_id_field');

  $('#associate_asset_modal').on('click', '.asset-area', function() {
    $('#cloud_asset_id_field').val($(this).find('.attachment').attr('data-id'));
    attachmentField.val(''); // Clear the value of attachmentField if cloudAssetIdField has a value
    $('#cloud_asset_file_name').val($(this).find('.attachment').attr('data-name'));
    $(this).siblings().removeClass('active');
    $(this).addClass('active');
  });

  $('#associate_asset_modal').on('dblclick', '.asset-area', function() {
    $('#cloud_asset_id_field').val($(this).find('.attachment').attr('data-id'));
    attachmentField.val(''); // Clear the value of attachmentField if cloudAssetIdField has a value
    $('#cloud_asset_file_name').val($(this).find('.attachment').attr('data-name'));
    $('.close').click();
  });

  $(".attach-btn").on('click', function() {
    $('.close').click();
  })

  attachmentField.change(function() {
    if ($(this).val()) {
      cloudAssetIdField.val(''); // Clear the value of cloudAssetIdField if attachmentField has a value
    }
  });
});
