$(document).ready(function() {
  // jQuery UI Dialogs
  $('#dialog-delete').dialog({
    autoOpen: false,
    width: 500,
    buttons: [
      {
        text: "Yes",
        click: function() {
          delete_user($(this).data('username'));
          $(this).dialog('close');
        }
      },
      {
        text: "Cancel",
        click: function() {
          $(this).dialog('close');
        }
      }
    ]
  });
  $('#dialog-reset').dialog({
    autoOpen: false,
    width: 500,
    buttons: [
      {
        text: "Reset",
        click: function() {
          reset_password($(this).data('username'), $('#new_password').val());
          $(this).dialog('close');
        }
      },
      {
        text: "Cancel",
        click: function() {
          $(this).dialog('close');
        }
      }
    ]
  });
  $('#dialog-confirm').dialog({
    autoOpen: false,
    width: 500,
    buttons: [
      {
        text: 'OK',
        click: function() {
          $(this).dialog('close');
        }
      }
    ]
  });
  $('#dialog-error').dialog({
    autoOpen: false,
    width: 500,
      classes: {
        "ui-dialog-titlebar": "red"
      },
    buttons: [
      {
        text: 'OK',
        click: function() {
          $(this).dialog('close');
        }
      }
    ]
  });
  
  // Prevent default form submission for password reset
  $('#form-reset').submit(function(e) {
    e.preventDefault();
  });
});

// Confirm deletion
function confirm_deletion(username) {
  $('#delete-username').text(username);
  $('#dialog-delete').data('username', username).dialog('open');
}

// Delete a user
function delete_user(username) {
  $.post('user-delete-process.php', {username: username}, function(data) {
    if (data == '') {
      $('table#users tbody tr td:first-child').each(function() {
        if ($(this).text() == username) {
          $(this).parent('tr').remove();
        }
      });
      action_success('User ' + username + ' deleted');
    }
    else {
      action_error(data);
    }
  });
}

function confirm_reset(username) {
  $('#reset-username').text(username);
  $('#dialog-reset').data('username', username).dialog('open');
}

// Reset a password
function reset_password(username, new_password) {
  $.post('user-password-reset.php', {username:username, new_password:new_password}, function(data) {
    if (data == '') {
      action_success('Password reset for ' + username);
    }
    else {
      action_error(data);
    }
  });
}

// Confirm action
function action_success(message) {
  $('#dialog-confirm').text(message).dialog('open');
}

// Error dialog
function action_error(message) {
  $('#dialog-error').text(message).dialog('open');
}