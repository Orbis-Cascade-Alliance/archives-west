import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $d as xs:string external;
declare variable $f as xs:string external;
let $db := 'eads' || $d
let $ead := doc($db || '/' || $f)//ead
let $ark := aw:get_ark($ead)
let $title := aw:get_title_with_date($ead)
let $date := aw:get_aw_date($ead)
let $abstract := aw:get_abstract($ead)
return
<ead>
  <db>{$d}</db>
  <ark>{$ark}</ark>
  <title>{$title}</title>
  <date>{$date}</date>
  <abstract>{$abstract}</abstract>
</ead>