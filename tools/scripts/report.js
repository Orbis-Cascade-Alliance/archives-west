$(document).ready(function() {
  $('.date').datepicker({
    dateFormat: "yy-mm-dd"
  });
  
  $('#dialog-dates').dialog({
    autoOpen: false,
    width: 500
  });
  
  $('#form-report').submit(function(e) {
    e.preventDefault();
    get_report();
  });
});

function get_report() {
  var start = $('#start').val();
  var end = $('#end').val();
  if (start != '' && end != '') {
    $('#report').html('<img id="loading" src="/layout/images/loading.gif" alt="Loading..." />');
    $.post('report-process.php', {start: start, end: end}, function(data) {
      $('#report').html(data);
    });
  }
  else {
    $('#report').html('<p class="errors">Start and end date are required.</p>');
  }
}

function export_csv() {
  var csv = "data:text/csv;charset=utf-8,";
  var row_values;
  jQuery('#views-by-ark tr').each(function() {
    row_values = [];
    jQuery(this).children().each(function() {
      row_values.push(jQuery(this).text().replaceAll('"','""'));
    });
    csv += "\"" + row_values.join("\",\"") + "\"\r\n";
  });
  var start = $('#start').val();
  var end = $('#end').val();
  var encoded_csv = encodeURI(csv).replaceAll('#', '%23');
  var download_link = document.createElement('a');
  download_link.download = "aw_views_" + start + "_to_" + end + ".csv";
  download_link.href = encoded_csv;
  download_link.click();
  download_link.remove();
}