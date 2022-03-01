import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $d as xs:string external;
declare variable $f as xs:string external;
declare variable $o as xs:boolean external;
let $ead := doc('eads' || $d || '/' || $f)//ead 
let $ark := aw:get_ark($ead)
let $title := aw:get_title($ead)
let $aw_date := aw:get_aw_date($ead)
let $tokens := ft:tokenize(string-join($ead//text(), ' '))
let $result := <ead ark="{$ark}" title="{$title}" date="{$aw_date}">{$tokens}</ead>
return
  if ($o) then (insert node $result as last into db:open('text' || $d)/eads, db:optimize('text' || $d))
  else insert node $result as last into db:open('text' || $d)/eads