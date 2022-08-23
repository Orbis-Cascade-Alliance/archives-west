(: Delete EADs by ARK from the working brief index :)
declare variable $a as xs:string external;
let $db_arks := tokenize($a, '\|')
let $delete_from_brief := %updating function($db_arks) {
  for $db_ark in $db_arks
    let $db_id := substring-before($db_ark, ':')
    let $ark := substring-after($db_ark, ':')
    return delete node db:get('index-brief')/eads[@db=$db_id]/ead[@ark=$ark]
}
return updating $delete_from_brief($db_arks), db:optimize('index-brief')