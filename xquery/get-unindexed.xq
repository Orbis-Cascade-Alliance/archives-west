declare variable $d as xs:string external;
<results>{
for $db_id in tokenize($d, '\|')
  let $brief_arks := db:open('index-brief')/eads/ead/@ark
  for $ark in db:open('eads' || $db_id)/ead/eadheader/eadid/@identifier[not(. = $brief_arks)]
    return <result>
      <db>{$db_id}</db>
      <ark>{string($ark)}</ark>
    </result>
}</results>