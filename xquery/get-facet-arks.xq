(: Get ARKs of finding aids that contain given facet terms in the production indexes :)
declare variable $d as xs:string external;
declare variable $f as xs:string external;
declare function local:get_arks($facet as xs:string, $db_ids as item()+) as item()* {
  let $type := substring-before($facet, ':')
  let $term := substring-after($facet, ':')
  return db:get('facet-' || $type || '-prod')/terms[@db=$db_ids]/term[@text=$term]/ark
};
let $db_ids := tokenize($d, '\|')
let $facets := tokenize($f, '\|')
let $arks :=
  fold-left(
    $facets,
    local:get_arks(head($facets), $db_ids),
    function($all_arks, $facet) { 
      let $facet_arks := local:get_arks($facet, $db_ids)
      let $arks_in_both := distinct-values($all_arks[.=$facet_arks])
      return $arks_in_both
    }
  )
return <arks>{
  for $ark in $arks
    return <ark>{$ark}</ark>
}</arks>