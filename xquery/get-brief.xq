declare variable $a as xs:string external;
<eads>
{
let $arks := tokenize($a, '\|')
  for $ead in db:open('index-brief')/eads/ead[ark/text()=$arks]
    return $ead
}
</eads>