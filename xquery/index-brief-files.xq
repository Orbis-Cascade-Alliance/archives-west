(: Add specific EAD files to the working brief index :)
import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $f as xs:string external;
let $files := tokenize($f, '\|')
let $add_to_brief := %updating function($files) {
  for $file in $files
    let $db_id := substring-before($file, ':')
    let $filename := substring-after($file, ':')
    let $ead := doc('eads' || $db_id || '/' || $filename)/ead
    let $ark := aw:get_ark($ead)
    let $title := aw:get_title_with_date($ead)
    let $date := aw:get_aw_date($ead)
    let $abstract := aw:get_abstract($ead)
    let $result := <ead db="{$db_id}" ark="{$ark}">
      <title>{$title}</title>
      <date>{$date}</date>
      <abstract>{$abstract}</abstract>
    </ead>
    return insert node $result as last into db:open('index-brief')/eads[@db=$db_id]
}
return updating $add_to_brief($files), db:optimize('index-brief')


