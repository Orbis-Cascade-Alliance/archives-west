<?php
// AW_S3 saves copies of EADs to the AWS S3 buckets
// Examples: https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/php_s3_code_examples.html
require AW_HTML . '/aws/vendor/autoload.php';
use Aws\S3\S3Client;
use Aws\Exception\AwsException;
use Aws\S3\Exception\S3Exception;

class AW_S3 {
  public $bucket;
  public $region;
  public $storage_class;
  public $path;
  private $client;
  
  function __construct($bucket, $region, $storage_class, $path) {
    $this->bucket = $bucket;
    $this->region = $region;
    $this->storage_class = $storage_class;
    $this->path = $path;
  }
  
  function get_key($file_path) {
    return $this->path . $file_path;
  }
  
  function get_client() {
    if (!isset($this->client)) {
      try {
        $this->client = new Aws\S3\S3Client([
          'version' => 'latest',
          'region' => $this->region
        ]);
      }
      catch (S3Exception $e) {
        throw new Exception('S3Exception: ' . $e->getMessage());
      }
      catch (AwsException $e) {
        throw new Exception('AwsException: ' . $e->getMessage());
      }
    }
    return $this->client;
  }
  
  function put_file($file_path, $file_contents) {
    $client = $this->get_client();
    try {
      $result = $client->putObject([
        'Bucket' => $this->bucket,
        'Key' => $this->get_key($file_path),
        'StorageClass' => $this->storage_class,
        'Body' => $file_contents
      ]);
    }
    catch (S3Exception $e) {
      throw new Exception('S3Exception: ' . $e->getMessage());
    }
    catch (AwsException $e) {
      throw new Exception('AwsException: ' . $e->getMessage());
    }
  }
  
  function delete_files($files) {
    $objects = array();
    foreach ($files as $file_path) {
      $objects[] = [
        'Key' => $this->get_key($file_path)
      ];
    }
    $client = $this->get_client();
    try {
      $result = $client->deleteObjects([
        'Bucket' => $this->bucket,
        'Delete' => [
          'Objects' => $objects
        ]
      ]);
    }
    catch (S3Exception $e) {
      throw new Exception('S3Exception: ' . $e->getMessage());
    }
    catch (AwsException $e) {
      throw new Exception('AwsException: ' . $e->getMessage());
    }
  }
  
}