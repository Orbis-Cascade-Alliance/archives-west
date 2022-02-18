declare variable $a as xs:string external;
declare variable $n as xs:string external;
<facets>
{
let $arks := tokenize($a, '\|')
let $names := tokenize($n, '\|')
for $name in $names
  let $facet_db := 'facet-' || $name
  return <facet type="{$name}">{
    for $term in db:open($facet_db)/terms/term[ark/text()=$arks]
      group by $text := $term/@text
      let $count := count($term/ark[text()=$arks])
      order by $count descending
      return <term text="{$text}" count="{$count}"/>
    }</facet>
}
</facets>