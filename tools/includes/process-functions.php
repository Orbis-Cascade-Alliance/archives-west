<?php
// Functions for running processes in the background and tracking them

// Check for running process
function check_process($script) {
  exec('ps -u www-data -f', $output);
  foreach ($output as $line) {
    if (stristr($line, $script)) {
      return true;
    }
  }
  return false;
}

// If no caching process is currently running, create the cached file in the background
// If a process is running, the cache-track.php script will call cache_next() when it's done
function start_cache_process($ark) {
  $current_process = check_process('cache.php');
  if (!$current_process) {
    $cache_process = new AW_Process('php ' . AW_HTML . '/tools/cache.php ' . $ark);
    new AW_Process('php ' . AW_HTML . '/tools/track-process.php cache ' . $cache_process->getPid() . ' ' . $ark);
  }
}

// Cache the next waiting finding aid with a cached value of 0
function cache_next() {
  if ($mysqli = connect()) {
    $ark_result = $mysqli->query('SELECT ark FROM arks WHERE cached=0 AND active=1 AND file<>"" ORDER BY date ASC LIMIT 1');
    if ($ark_result->num_rows == 1) {
      while ($ark_row = $ark_result->fetch_row()) {
        start_cache_process($ark_row[0]);
      }
    }
    $mysqli->close();
  }
}

// Run an index update as a process
function start_index_process() {
  $current_process = check_process('update-indexes.php');
  if (!$current_process) {
    $index_process = new AW_Process('php ' . AW_HTML . '/tools/update-indexes.php');
    new AW_Process('php ' . AW_HTML . '/tools/track-process.php index ' . $index_process->getPid());
  }
}

// Update indexes if any update rows have a complete value of 0
function index_next() {
  if ($mysqli = connect()) {
    $update_result = $mysqli->query('SELECT id FROM updates WHERE complete=0');
    if ($update_result->num_rows > 0) {
      start_index_process();
    }
    $mysqli->close();
  }
}

// Harvest EADs from ArchivesSpace
function start_harvest_process($harvest_id, $job_id) {
  $current_process = check_process('get-ead.php');
  if (!$current_process) {
    $harvest_process = new AW_Process('php ' . AW_HTML . '/tools/oai-pmh/get-ead.php ' . $harvest_id);
    new AW_Process('php ' . AW_HTML . '/tools/track-process.php harvest ' . $harvest_process->getPid() . ' ' . $job_id);
  }
}

// Harvest next incomplete ArchivesSpace record from harvests table
function harvest_next($job_id) {
  if ($mysqli = connect()) {
    $harvest_result = $mysqli->query('SELECT id FROM harvests WHERE job_id=' . $job_id . ' AND downloaded=0 LIMIT 1');
    if ($harvest_result->num_rows == 1) {
      while ($harvest_row = $harvest_result->fetch_row()) {
        start_harvest_process($harvest_row[0], $job_id);
      }
    }
    else {
      upload_next($job_id);
    }
    $mysqli->close();
  }
}

// Process a batch of harvested ArchivesSpace records
function start_upload($job_id) {
  $current_process = check_process('upload-eads.php');
  if (!$current_process) {
    $upload_process = new AW_Process('php ' . AW_HTML . '/tools/oai-pmh/upload-eads.php ' . $job_id);
    new AW_Process('php ' . AW_HTML . '/tools/track-process.php upload ' . $upload_process->getPid() . ' ' . $job_id);
  }
}

// Upload next batch of harvested ArchivesSpace records
function upload_next($job_id) {
  if ($mysqli = connect()) {
    $uploaded_result = $mysqli->query('SELECT id FROM harvests WHERE job_id=' . $job_id . ' AND downloaded=1 AND uploaded=0');
    if ($uploaded_result->num_rows > 0) {
      start_upload($job_id);
    }
    else {
      $job = new AW_Job($job_id);
      $job->set_complete();
      index_next();
    }
    $mysqli->close();
  }
}

// Harvest EADs from ArchivesSpace
function start_harvest_process_api($harvest_id, $job_id, $as_session, $as_expires) {
  $current_process = check_process('get-ead.php');
  if (!$current_process) {
    $harvest_process = new AW_Process('php ' . AW_HTML . '/tools/archivesspace/get-ead.php ' . $harvest_id . ' ' . $as_session . ' ' . $as_expires);
    new AW_Process('php ' . AW_HTML . '/tools/track-process.php harvest-api ' . $harvest_process->getPid() . ' ' . $job_id. ' ' . $as_session . ' ' . $as_expires);
  }
}

// Harvest next incomplete ArchivesSpace record from harvests table
function harvest_next_api($job_id, $as_session, $as_expires) {
  if ($mysqli = connect()) {
    $harvest_result = $mysqli->query('SELECT id FROM harvests WHERE job_id=' . $job_id . ' AND downloaded=0 LIMIT 1');
    if ($harvest_result->num_rows == 1) {
      while ($harvest_row = $harvest_result->fetch_row()) {
        start_harvest_process_api($harvest_row[0], $job_id, $as_session, $as_expires);
      }
    }
    else {
      upload_next_api($job_id, $as_session, $as_expires);
    }
    $mysqli->close();
  }
}

// Process a batch of harvested ArchivesSpace records
function start_upload_api($job_id, $as_session, $as_expires) {
  $current_process = check_process('upload-eads.php');
  if (!$current_process) {
    $upload_process = new AW_Process('php ' . AW_HTML . '/tools/archivesspace/upload-eads.php ' . $job_id . ' ' . $as_session . ' ' . $as_expires);
    new AW_Process('php ' . AW_HTML . '/tools/track-process.php upload-api ' . $upload_process->getPid() . ' ' . $job_id . ' ' . $as_session . ' ' . $as_expires);
  }
}

// Upload next batch of harvested ArchivesSpace records
function upload_next_api($job_id, $as_session, $as_expires) {
  if ($mysqli = connect()) {
    $uploaded_result = $mysqli->query('SELECT id FROM harvests WHERE job_id=' . $job_id . ' AND downloaded=1 AND uploaded=0');
    if ($uploaded_result->num_rows > 0) {
      start_upload_api($job_id, $as_session, $as_expires);
    }
    else {
      $job = new AW_Job($job_id);
      $job->set_complete();
      index_next();
    }
    $mysqli->close();
  }
}

?>