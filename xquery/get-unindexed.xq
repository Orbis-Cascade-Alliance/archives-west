import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $d as xs:string external;
<files>{
  for $db_id in tokenize($d, '\|')
    let $brief_arks := db:open('index-brief')/eads/ead/@ark
    for $ead in db:open('eads' || $db_id)/ead[not(eadheader/eadid/@identifier = $brief_arks)]
      return <file>{$db_id}:{db:path($ead)}</file>
}</files>
