$(document).ready(function() {
  $('#form-download').submit(function(e) {
    e.preventDefault();
    download_ead();
    return false;
  });
});

function download_ead() {
  var ead = $('#converted-ead').val();
  var encoded_ead = encodeURIComponent(ead);
  var filename = 'ead.xml';
  var match = ead.match(/<eadid[^>]+>([^<]+)<\/eadid>/);
  if (typeof(match) != null) {
    var filename = match[1];
  }
  var download_link = document.createElement('a');
  download_link.download = filename;
  download_link.href = "data:text/xml;charset=utf-8," + encoded_ead;
  download_link.click();
  download_link.remove();
}