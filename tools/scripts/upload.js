function preview() {
  if ($('#ead').val()) {
    var form_preview = $('#form-upload').clone();
    form_preview.attr('id', 'form-preview');
    form_preview.attr('action', 'preview-process.php');
    form_preview.attr('target', '_blank');
    form_preview.find('input[name="ark"], input#replace, input[type="submit"]').remove();
    $('#form-upload').after(form_preview);
    form_preview.submit();
    $('#form-preview').remove();
  }
  else {
    $('#form-upload').before('<ul class="errors"><li>File is empty.</li></ul>');
  }
}