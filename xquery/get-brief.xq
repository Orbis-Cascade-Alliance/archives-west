declare variable $a as xs:string external;
<eads>
{
let $arks := tokenize($a, '\|')
  for $ead in db:open('index-brief-prod')/eads/ead[@ark=$arks]
    return $ead
}
</eads>