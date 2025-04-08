var formData = new FormData();

$(document).ready(function(){
  // jQuery UI Dialogs
  $('#dialog-error').dialog({
    autoOpen: false,
    width: 500
  });
  
  // Dropzone behavior
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
  
  // Browse upload alternative
  $('#btn-manual').click(function() {
    $('#manual').click();
  });
  
  $('#manual').change(function(e) {
    append_to_formdata(e.target.files);
    update_dropzone();
    $(this).val('');
  });
  
  // Form submission
  $('#form-files').submit(function(e) {
    e.preventDefault();
    if (validate_files() === true) {
      $('#report').html('Processing...');
      $('.loading').show();
      $('#form-files').hide();
      if ($('#replace_files').is(":checked")) {
        formData.set('replace_files', 1);
      }
      else {
        formData.set('replace_files', 0);
      }
      $.ajax({
        url: 'batch-process.php',
        type: 'post',
        processData: false,
        contentType: false,
        data: formData,
        success: function(data) {
          $('.loading').hide();
          $('#report').html(data);
          formData.delete('file[]');
          update_dropzone();
          $('#form-files').show();
        }
      });
    }
    else {
      $('#dialog-error').dialog('open');
    }
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

function toggle_cr(btn) {
  var p = $(btn).parent('p');
  var report = p.next('.compliance-report');
  if ($(report).is(':visible')) {
    $(report).hide();
    $(btn).text('View Report');
  }
  else {
    $(report).show();
    $(btn).text('Hide Report');
  }
}

function validate_files() {
  if (formData.getAll('file[]').length > max_files) {
    return false;
  }
  else {
    return true;
  }
}