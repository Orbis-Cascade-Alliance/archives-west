import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $d as xs:string external;
let $add_to_text := %updating function($d) {
  for $ead in db:open('eads' || $d)/ead 
    let $ark := aw:get_ark($ead)
    let $title := aw:get_title($ead)
    let $aw_date := aw:get_aw_date($ead)
    let $tokens := ft:tokenize(string-join($ead//text(), ' '))
    let $result := <ead ark="{$ark}">
      <title>{$title}</title>
      <date>{$aw_date}"</date>
      <tokens>{$tokens}</tokens>
    </ead>
    return insert node $result into db:open('text' || $d)/eads
}
return updating $add_to_text($d), db:optimize('text' || $d)