$(document).ready(function() {
  $('#dialog-appnote').dialog({
    autoOpen: false,
    width: 500,
    maxHeight: ($(window).height())*.75,
    open: function() {
      $(this).dialog('option', 'maxHeight', ($(window).height())*.75);
    }
  });
  $('#dialog-source').dialog({
    autoOpen: false,
    width: 800,
    maxHeight: ($(window).height())*.75,
    open: function() {
      $(this).dialog('option', 'maxHeight', ($(window).height())*.75);
    }
  });
});

function getAppNotes(notes_id) {
  var escaped_notes_id = notes_id.replace('.', '\\.');
  var notes = $('#' + escaped_notes_id);
  var notes_header = notes.find('h4').eq(0).text();
  if (notes_header == '') {
    notes_header = 'Comments/Application Notes';
  }
  notes.find('h4').remove()
  var notes_body = notes.html();
  $('.dialog').dialog('close');
  $('#dialog-appnote').html(notes_body).dialog({title: notes_header}).dialog('open');
}

function writeSource(id) {
  var source_code = $('#source').find('div#' + id).html();
  $('.dialog').dialog('close');
  $('#dialog-source').html('<code>' + source_code + '</code>').dialog('open');
}