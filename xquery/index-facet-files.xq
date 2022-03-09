(: Add specific EAD files to the working facet indexes :)
import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $t as xs:string external;
declare variable $f as xs:string external;
declare variable $types as xs:string+ := tokenize($t, '\|');

let $files := tokenize($f, '\|')
let $add_to_facets := %updating function($types, $files) {
  for $type in $types
    let $facet_db := 'facet-' || substring-before($type, ':')
    let $local_names := tokenize(substring-after($type, ':'), ',')
    for $file in $files
      let $db_id := substring-before($file, ':')
      let $filename := substring-after($file, ':')
      let $doc := doc('eads' || $db_id || '/' || $filename)
      let $ark := aw:get_ark($doc/ead)
      for $terms in $doc//controlaccess/*[local-name()=$local_names]
        let $text := normalize-space(translate($terms, '&#160;', ' '))
        group by $text, $ark, $db_id, $facet_db
          where not($text="")
            let $existing_term := db:open($facet_db)/terms[@db=$db_id]/term[@text=$text]
            return
              if (exists($existing_term)) then
                insert node <ark>{$ark}</ark> as last into $existing_term
              else
                insert node <term text="{$text}"><ark>{$ark}</ark></term> as last into db:open($facet_db)/terms[@db=$db_id]
}
return updating $add_to_facets($types, $files), 

let $optimize_facets := %updating function($types) {
  for $type in $types 
    return db:optimize('facet-' || substring-before($type, ':'))
}
return updating $optimize_facets($types)