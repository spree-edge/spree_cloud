$(document).on('turbo:load', function () {
  const attachmentField = $('#image_attachment');
  $('.upload_asset_button').on('click', function() {
    const cloudAssetIdField = this.dataset.inputFieldId;
    const targetModalFieldName = this.dataset.inputId;

    // Remove any previously bound click or dblclick handlers to avoid duplicates
    $('#associate_asset_modal')
    .off('click', '.asset-area') // Remove existing click handlers
    .off('dblclick', '.asset-area'); // Remove existing dblclick handlers

    $('#associate_asset_modal').on('click', '.asset-area', function() {
      $(`#${cloudAssetIdField}`).val($(this).find('.attachment').attr('data-id'));
      attachmentField.val(''); // Clear the value of attachmentField if cloudAssetIdField has a value
      $(`#${targetModalFieldName}`).val($(this).find('.attachment').attr('data-name'));
      $(this).siblings().removeClass('active');
      $(this).addClass('active');
    });


    $('#associate_asset_modal').on('dblclick', '.asset-area', function(e) {
      $(`#${cloudAssetIdField}`).val($(this).find('.attachment').attr('data-id'));
      attachmentField.val(''); // Clear the value of attachmentField if cloudAssetIdField has a value
      $(`#${targetModalFieldName}`).val($(this).find('.attachment').attr('data-name'));
      $('.cloud-close-modal').click();
    });

    $(".attach-btn").on('click', function() {
      $('.cloud-close-modal').click();
    })

    $(".cancel-btn").on('click', function(){
      cloudAssetIdField.val(''); // Clear the value of cloudAssetIdField if attachmentField has a value
      $(`#${targetModalFieldName}`).val('')
      $('.cloud-close-modal').click();
    })

    $('.cloud-close-modal').on('click', function(){
      $('.asset-area.active').removeClass('active');
    })

    attachmentField.change(function() {
      if ($(this).val()) {
        cloudAssetIdField.val(''); // Clear the value of cloudAssetIdField if attachmentField has a value
        $(`#${targetModalFieldName}`).val('')
      }
    });
  });
});
