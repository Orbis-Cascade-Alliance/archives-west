(: Delete EADs by ARK from the working facet indexes :)
import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $t as xs:string external;
declare variable $a as xs:string external;
declare variable $types as xs:string+ := tokenize($t, '\|');

let $db_arks := tokenize($a, '\|')
let $delete_from_facets := %updating function($types, $db_arks) {
  for $type in $types
    let $facet_db := 'facet-' || substring-before($type, ':')
    for $db_ark in $db_arks
      let $db_id := substring-before($db_ark, ':')
      let $ark := substring-after($db_ark, ':')
      return delete node db:get($facet_db)/terms[@db=$db_id]/term/ark[text()=$ark]
}
return updating $delete_from_facets($types, $db_arks),

let $delete_empty_terms := %updating function($types) {
  for $type in $types
    let $facet_db := 'facet-' || substring-before($type, ':')
    return delete node db:get($facet_db)/terms/term[not(descendant::ark)]
}
return updating $delete_empty_terms($types),

let $optimize_facets := %updating function($types) {
  for $type in $types 
    return db:optimize('facet-' || substring-before($type, ':'))
}
return updating $optimize_facets($types)