var formData = new FormData();

$(document).ready(function(){
  $('.dropzone').on({
    dragover: function(e) {
      e.stopPropagation();
      e.preventDefault();
      $(this).addClass('highlight');
      return false;
    },
    dragleave: function(e) {
      e.stopPropagation();
      e.preventDefault();
      $(this).removeClass('highlight');
      return false;
    },
    drop: function(e) {
      e.stopPropagation();
      e.preventDefault();
      $(this).removeClass('highlight');
      append_to_formdata(e.originalEvent.dataTransfer.files);
      update_dropzone();
      return false;
    }
  });
  
  $('#manual').change(function(e) {
    append_to_formdata(e.target.files);
    update_dropzone();
    $(this).val('');
  });
  
  $('#form-files').submit(function(e) {
    e.preventDefault();
    $('#report').html('<p>Processing...</p>');
    $.ajax({
      url: 'batch-process.php',
      type: 'post',
      processData: false,
      contentType: false,
      data: formData,
      success: function(data) {
        $('#report').html(data);
        formData.delete('file[]');
        update_dropzone();
      }
    });
    return false;
  });
});

function append_to_formdata(files) {
  for (f = 0; f < files.length; f++) {
    formData.append('file[]', files[f]);
  }
}

function update_dropzone() {
  var files = formData.getAll('file[]');
  if (files.length > 0) {
    $('#instructions').hide();
    $('#list li').remove();
    for (f = 0; f < files.length; f++) {
      $('#list').append('<li>' + files[f].name + ' <button type="button" class="btn-delete" onclick="remove_file(' + f + ')">X</button></li>');
    }
    $('#list, #upload').show();
  }
  else {
    $('#instructions').show();
    $('#list, #upload').hide();
  }
}

function remove_file(index) {
  var files = formData.getAll('file[]');
  files.splice(index, 1);
  formData.delete('file[]');
  append_to_formdata(files);
  update_dropzone();
}

function toggle_cr(index) {
  if ($('#cr' + index).is(':visible')) {
    $('#cr' + index).hide();
    $('#btn-cr' + index).text('View Report');
  }
  else {
    $('#cr' + index).show();
    $('#btn-cr' + index).text('Hide Report');
  }
}