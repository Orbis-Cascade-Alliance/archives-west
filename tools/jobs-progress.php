<?php
// Print current progress of an AS harvest job

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');

if (isset($_GET['j']) && !empty($_GET['j'])) {
  $job_id = filter_var($_GET['j'], FILTER_SANITIZE_NUMBER_INT);
  $total = 0;
  $downloaded = 0;
  $uploaded = 0;
  $arks = 0;
  if ($mysqli = connect()) {
    $harvest_result = $mysqli->query('SELECT
      jobs.complete,
      COUNT(*) as total_count,
      COUNT(CASE WHEN downloaded=1 THEN 1 END) as downloaded_count,
      COUNT(CASE WHEN downloaded<>0 THEN 1 END) as downloads_processed,
      COUNT(CASE WHEN uploaded=1 THEN 1 END) as uploaded_count,
      COUNT(CASE WHEN uploaded<>0 THEN 1 END) as uploads_processed,
      COUNT(CASE WHEN ark <> NULL THEN 1 END) as ark_count
      FROM harvests LEFT JOIN jobs ON harvests.job_id=jobs.id
      WHERE job_id=' . $job_id);
    while ($harvest_row = $harvest_result->fetch_assoc()) {
      $complete = $harvest_row['complete']; 
      $total = $harvest_row['total_count'];
      $downloaded = $harvest_row['downloaded_count'];
      $downloads_processed = $harvest_row['downloads_processed'];
      $uploaded = $harvest_row['uploaded_count'];
      $uploads_processed = $harvest_row['uploads_processed'];
      $arks = $harvest_row['ark_count'];
    }
    $mysqli->close();
  }
  
  if ($complete == 0) {
    if ($total == 0) {
      echo '<div id="step1" class="active">Getting identifiers from ArchivesSpace</div>';
    }
    else {
      echo '<div id="step1" class="finished">Found ' . $total . ' identifiers in ArchivesSpace.</div>';
      if ($downloaded == 0) {
        echo '<div id="step2" class="active">Downloading EADs of ArchivesSpace resources.</div>';
      }
      else {
        if ($downloads_processed < $total) {
          echo '<div id="step2" class="active">Downloaded ' . $downloaded . ' of ' . $total . ' resources.</div>';
        }
        else {
          echo '<div id="step2" class="finished">Downloaded all available resources from ArchivesSpace.</div>';
          if ($uploaded == 0) {
            echo '<div id="step3" class="active">Converting and uploading ArchivesSpace EADs.</div>';
          }
          else {
            if ($uploads_processed < $downloads_processed) {
              echo '<div id="step3" class="active">Uploaded ' . $uploaded . ' of ' . $downloads_processed . ' EADs.</div>';
            }
            else {
              echo '<div id="step3" class="finished">Uploaded all available ArchivesSpace EADs.</div>';
            }
          }
        }
      }
    }
  }
  else {
    echo 'Job complete!';
  }
}
?>