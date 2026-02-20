<?php
// AW_SQS sends messages to queues
// Examples: https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/sqs-examples.html
require_once AW_HTML . '/aws/vendor/autoload.php';
use Aws\Sqs\SqsClient;
use Aws\Exception\AwsException;

class AW_SQS {
  public $queue_url;
  public $region;
  private $client;
  
  function __construct($queue_url, $region) {
    $this->queue_url = $queue_url;
    $this->region = $region;
  }
  
  function get_client() {
    if (!isset($this->client)) {
      try {
        $this->client = new Aws\Sqs\SqsClient([
          'profile' => 'default',
          'version' => 'latest',
          'region' => $this->region
        ]);
      }
      catch (AwsException $e) {
        throw new Exception('AwsException: ' . $e->getAwsErrorMessage());
      }
    }
    return $this->client;
  }
  
  function get_queue_url() {
    return $this->queue_url;
  }
  
  function send_message($body) {
    $client = $this->get_client();
    try {
      $params = [
        'QueueUrl' => $this->get_queue_url(),
        'MessageBody' => $body,
        'DelaySeconds' => 10
      ];
      $result = $client->sendMessage($params);
    }
    catch (AwsException $e) {
      throw new Exception('AwsException: ' . $e->getMessage());
    }
  }
  
}