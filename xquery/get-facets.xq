(: Get facet terms for ARKs from the production indexes :)
declare variable $a as xs:string external;
declare variable $n as xs:string external;
declare variable $m as xs:integer external;
<facets>
{
let $arks := tokenize($a, '\|')
let $names := tokenize($n, '\|')
for $name in $names
  let $facet_db := 'facet-' || $name || '-prod'
  let $sorted_terms := <terms>{
    for $term in db:get($facet_db)/terms/term[ark/text()=$arks]
      group by $text := $term/@text
      let $count := count($term/ark[text()=$arks])
      order by $count descending
      return <term text="{$text}" count="{$count}"/>
  }</terms>
  return <facet type="{$name}">{
    for $term at $index in subsequence($sorted_terms/term, 1, $m)
      return $term
  }</facet>
}
</facets>