(: Get brief records by ARK with full-text matches for a query :)
declare variable $a as xs:string external;
declare variable $q as xs:string external;
declare variable $f as xs:string external;

declare function local:get_marks($db as xs:string, $ark as xs:string, $terms as xs:string+, $fuzzy as xs:string) as element(marks) {
  <marks>{
    if ($fuzzy eq "true") then ft:mark(db:get($db)/eads/ead[@ark=$ark]/tokens/text()[. contains text {$terms} using fuzzy])
    else ft:mark(db:get($db)/eads/ead[@ark=$ark]/tokens/text()[. contains text {$terms}])
  }</marks>
};

<eads>
{
let $terms := tokenize($q, '\|')
let $arks := tokenize($a, '\|')
  for $ead in db:get('index-brief-prod')/eads/ead[@ark=$arks]
    let $d := string($ead/@db)
    let $db := 'text' || $d || '-prod'
    let $ark := string($ead/@ark)
    let $matches := distinct-values(local:get_marks($db, $ark, $terms, $f)/mark)
    return
    <ead db="{$d}" ark="{$ark}">
      <title>{$ead/title/text()}</title>
      <date>{$ead/date/text()}</date>
      <abstract>{$ead/abstract/text()}</abstract>
      <matches>{string-join($matches, ",")}</matches>
    </ead>
}
</eads>