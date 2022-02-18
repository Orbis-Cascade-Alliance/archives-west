$(document).ready(function() {
  // Attach handler to repository form
  $('#form-repo select[name="r"]').change(function() {
    $(this).parents('form').submit();
  });
});