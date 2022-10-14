<?php
$as_host = filter_var($_GET['host'], FILTER_SANITIZE_URL);
if (substr($as_host, -1) == '/') {
  $as_host = substr($as_host, 0, (strlen($as_host) - 1));
}
$url = $as_host . '/oai?verb=Identify';
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
curl_setopt($ch, CURLOPT_TIMEOUT, 10);
$response = curl_exec($ch);
curl_close($ch);
if ($response === false) {
  echo 'Error: Unable to connect to OAI-PMH service at ' . $as_host;
}
else {
  echo 'Success!';
}
?>