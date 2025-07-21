<?php
// AW_CloudFront is used to invalidate caches in the archives-west distribution
// Examples: https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/php/example_code/cloudfront
require_once AW_HTML . '/aws/vendor/autoload.php';
use Aws\Exception\AwsException;

class AW_CloudFront {
  
  private $client;
  public $distribution_id;
  public $region;
  
  function __construct($distribution_id, $region) {
    $this->distribution_id = $distribution_id;
    $this->region = $region;
  }
  
  function get_client() {
    if (!isset($this->client)) {
      try {
        $this->client = new Aws\CloudFront\CloudFrontClient([
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
  
  function create_invalidation($paths) {
    $client = $this->get_client();
    $callerReference = uniqid();
    try {
      $result = $cloudFrontClient->createInvalidation([
        'DistributionId' => $this->distribution_id,
        'InvalidationBatch' => [
          'CallerReference' => $callerReference,
          'Paths' => [
              'Items' => $paths,
              'Quantity' => count($paths)
          ],
        ]
      ]);
    }
    catch (AwsException $e) {
      throw new Exception('AwsException: ' . $e->getAwsErrorMessage());
    }
  }
  
}