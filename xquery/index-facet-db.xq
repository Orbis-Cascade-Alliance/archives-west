declare variable $t as xs:string external;
declare variable $d as xs:string external;
declare variable $types as xs:string+ := tokenize($t, '\|');

let $add_terms := %updating function($types) {
  for $type in $types
    let $facet_db := 'facet-' || substring-before($type, ':')
    let $local_names := tokenize(substring-after($type, ':'), ',')
    let $result := <terms db="{$d}">{
      for $terms in db:open('eads' || $d)//controlaccess/*[local-name()=$local_names]
        let $text := normalize-space(translate($terms, '&#160;', ' '))
        group by $text
          where not($text="")
            return
              <term text="{$text}">{
                for $ark in distinct-values($terms/ancestor::ead/eadheader/eadid/@identifier)
                  return <ark>{$ark}</ark>
                }
              </term>
    }</terms>
    return db:add($facet_db, $result, 'eads' || $d)
}
return updating $add_terms($types),

let $optimize_facets := %updating function($types) {
  for $type in $types 
    return db:optimize('facet-' || substring-before($type, ':'))
}
return updating $optimize_facets($types)
