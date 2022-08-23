(: Add the EADs of a repository to the working brief index :)
import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $d as xs:string external;
let $db := 'eads' || $d
let $result := <eads db="{$d}">{
  for $ead in db:get($db)/ead
    let $ark := aw:get_ark($ead)
    let $title := aw:get_title_with_date($ead)
    let $date := aw:get_aw_date($ead)
    let $abstract := aw:get_abstract($ead)
    return
    <ead db="{$d}" ark="{$ark}">
      <title>{$title}</title>
      <date>{$date}</date>
      <abstract>{$abstract}</abstract>
    </ead>
}</eads>
return db:add('index-brief', $result, $db), db:optimize('index-brief')