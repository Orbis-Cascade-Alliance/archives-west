declare variable $a as xs:string external;
let $arks := tokenize($a, '\|')
let $delete_from_brief := %updating function($arks) {
  for $ark in $arks
    return delete node db:open('index-brief')/eads/ead[@ark=$ark]
}
return updating $delete_from_brief($arks), db:optimize('index-brief')