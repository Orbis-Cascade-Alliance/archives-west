$(document).ready(function() {
  $('#repo-select').change(function() {
    if ($(this).val() != '') {
      var url = document.URL.replace(/#.*$/, "");
      url = url + '#' + $(this).val();
      window.location.href = url;
    }
  });
});