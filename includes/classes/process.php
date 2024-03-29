<?php
/* An easy way to keep in track of external processes.
* Ever wanted to execute a process in php, but you still wanted to have somewhat controll of the process ? Well.. This is a way of doing it.
* @compability: Linux only. (Windows does not work).
* @author: Peec
* Source: https://www.php.net/manual/en/function.exec.php
*/
class AW_Process{
  private $pid;
  private $command;

  public function __construct($cl = false){
    if ($cl != false){
      $this->command = $cl;
      $this->runCom();
    }
  }
  private function runCom(){
    $command = 'export AW_HOME="' . getenv('AW_HOME') . '" && nohup ' . $this->command . ' > /dev/null 2>&1 & echo $!';
    exec($command, $op);
    $pid = (int) $op[0];
    $this->setPid($pid);
  }

  public function setPid($pid){
    $this->pid = $pid;
  }

  public function getPid(){
    return $this->pid;
  }

  public function status(){
    $command = 'ps -p ' . $this->pid;
    exec($command, $op);
    if (!isset($op[1])) {
      return false;
    }
    else {
      return true;
    }
  }

  // This command fails with permission denied for user www-data, even if www-data initiated the process.
  /*public function stop(){
    $command = 'kill ' . $this->pid;
    exec($command);
    if ($this->status() == false) {
      return true;
    }
    else {
      return false;
    }
  }*/
}
?>