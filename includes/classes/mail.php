<?php
// Construct and send an email message

class AW_Mail {
  
  public $to;
  public $subject;
  public $message;
  
  function __construct($to = '', $subject = '', $message = '') {
    $this->to = $to;
    $this->subject = $subject;
    $this->message = $message;
  }
  
  function set_to($to) {
    $this->to = $to;
  }
  
  function get_to() {
    return $this->to;
  }
  
  function set_subject() {
    $this->subject = $subject;
  }
  
  function get_subject() {
    return $this->subject;
  }
  
  function set_message($message) {
    $this->message = $message;
  }
  
  function get_message() {
    return $this->message;
  }
  
  function send() {
    $headers = 'From: ' . MAIL_FROM . "\r\n" .
      'Reply-To: ' . MAIL_REPLY_TO . "\r\n" .
      'X-Mailer: PHP/' . phpversion() . "\r\n" .
      'MIME-Version: 1.0' . "\r\n" .
      'Content-Type: text/html; charset=UTF-8' . "\r\n";
    mail($this->get_to(), $this->get_subject(), $this->get_message(), $headers);
  }
}





?>