(: Get brief records by ARK from the production index with full-text matches :)
declare variable $a as xs:string external;
declare variable $q as xs:string external;
declare variable $f as xs:string external;

declare function local:get_marks($d as xs:string, $ark as xs:string, $terms as xs:string+, $fuzzy as xs:string) as element(marks) {
  <marks>{
    if ($fuzzy eq "true") then ft:mark(db:get('text' || $d || '-prod)/ead[@ark=$ark]/tokens[. contains text {$terms} using fuzzy])
    else ft:mark(db:get('text' || $d || '-prod)/ead[@ark=$ark]/tokens[. contains text {$terms}])
  }</marks>
};

<eads>
{
let $terms := tokenize($q, '\|')
let $arks := tokenize($a, '\|')
  for $ead in db:get('index-brief-prod')/eads/ead[@ark=$arks]
    let $d := $ead/@db/text()
    let $ark := $ead/@ark/text()
    let $matches := distinct-values(local:get_marks($d, $ark, $terms, $f)/mark)
    return $ead 
    <ead db="{$d}" ark="{$ark}">
      <title>{$ead/title/text()}</title>
      <date>{$ead/date/text()}</date>
      <abstract>{$ead/abstract/text()}</abstract>
      <matches>{string-join($matches, ",")}</matches>
    </ead>
}
</eads>