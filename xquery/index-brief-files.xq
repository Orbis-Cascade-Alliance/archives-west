import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $f as xs:string external;
let $files := tokenize($f, '\|')
let $add_to_brief := %updating function($files) {
  for $file in $files
    let $d := substring-before($file, ':')
    let $f := substring-after($file, ':')
    let $ead := doc('eads' || $d || '/' || $f)/ead
    let $ark := aw:get_ark($ead)
    let $title := aw:get_title_with_date($ead)
    let $date := aw:get_aw_date($ead)
    let $abstract := aw:get_abstract($ead)
    let $result := <ead db="{$d}" ark="{$ark}">
      <title>{$title}</title>
      <date>{$date}</date>
      <abstract>{$abstract}</abstract>
    </ead>
    return insert node $result as last into db:open('index-brief')/eads[@db=$d]
}
return updating $add_to_brief($files), db:optimize('index-brief')


