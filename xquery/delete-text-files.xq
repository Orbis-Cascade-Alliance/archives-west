(: Delete EADs by ARK from the working text index :)
declare variable $a as xs:string external;
declare variable $db_arks as xs:string+ := tokenize($a, '\|');

let $delete_from_text := %updating function($db_arks) {
  for $db_ark in $db_arks
    let $db_id := substring-before($db_ark, ':')
    let $ark := substring-after($db_ark, ':')
    return delete node db:open('text' || $db_id)/eads/ead[@ark=$ark]
}
return updating $delete_from_text($db_arks), 

let $optimize_dbs := %updating function($db_arks) {
  let $db_ids := distinct-values(
    for $db_ark in $db_arks
      return substring-before($db_ark, ':')
  )
  for $db_id in $db_ids
    return db:optimize('text' || $db_id)
}
return updating $optimize_dbs($db_arks)