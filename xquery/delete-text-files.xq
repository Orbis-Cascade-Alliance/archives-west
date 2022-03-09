(: Delete EADs by ARK from the working text index :)
declare variable $a as xs:string external;
let $arks := tokenize($a, '\|')
let $delete_from_text := %updating function($arks) {
  for $ark in $arks
    return delete node db:open('index-text')/eads/ead[@ark=$ark]
}
return updating $delete_from_text($arks), db:optimize('index-text')