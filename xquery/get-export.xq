(: Export basic information about one or all EADs from a document database :)
(: Used for both the home table and export tool in management :)
(: Also used to get titles for finding aids on website :)
import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $d as xs:string external;
declare variable $a as xs:string external;
let $db := 'eads' || $d
return <eads>{
  for $ead in db:get($db)/ead
    let $ark := aw:get_ark($ead)
    where $a="" or $ark=$a
      let $title := aw:get_title($ead)
      let $date := aw:get_date($ead)
      let $modified := aw:get_aw_date($ead)
      let $collection := aw:concat_children($ead/archdesc/did/unitid, ', ')
      let $file := db:path($ead)
      return
      <ead>
        <ark>{$ark}</ark>
        <title>{$title}</title>
        <date>{$date}</date>
        <modified>{$modified}</modified>
        <collection>{$collection}</collection>
        <file>{$file}</file>
      </ead>
}</eads>