declare variable $a as xs:string external;
<eads>
{
let $arks := tokenize($a, '\|')
  for $ead in db:open('index-brief')/eads/ead[ark/text()=$arks]
    return <ead>
      <db>{string($ead/db)}</db>
      <ark>{string($ead/ark)}</ark>
      <title>{string($ead/title)}</title>
      <date>{string($ead/date)}</date>
    </ead>
}
</eads>