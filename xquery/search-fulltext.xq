(: Perform a full-text search of the production text index :)
import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $q as xs:string external;
declare variable $a as xs:string external;
declare variable $d as xs:string external;
declare variable $s as xs:string external;
declare variable $f as xs:string external;

declare function local:calculate_score($terms as xs:string+, $result as node()*, $title as xs:string, $basex_score as xs:double) as xs:double {
  let $in_title := xs:integer(ft:contains($title, $terms))
  let $exact := fold-left(
    $terms,
    local:in_string($result, string(head($terms))),
    function($running_boost, $term) { 
      let $term_boost := local:in_string($result, $term)
      return $running_boost + $term_boost
    }
  )
  let $phrase_boost := local:in_string($result, string-join($terms, ' '))
  let $score := $basex_score + $in_title + $exact + $phrase_boost
  return $score
};

declare function local:in_string($string as xs:string, $term as xs:string) as xs:integer {
  let $contains := xs:integer(xs:boolean(contains(lower-case($string), lower-case($term))))
  return $contains
};

let $terms := tokenize($q, '\|')
let $arks := tokenize($a, '\|')
let $db_ids := tokenize($d, '\|')
return <results>{
  for $db_id in $db_ids
    for $result score $basex_score in ft:search('text' || $db_id || '-prod', $terms, map{'mode':'all','fuzzy':$f})
      let $ead := $result/ancestor::ead
      let $ark := string($ead/@ark)
        where not($ark="") and (empty($arks) or $ark=$arks)
          let $title := string($ead/title)
          let $aw_date := string($ead/date)
          order by
            if ($s eq "score") then local:calculate_score($terms, $ead, $title, $basex_score) else() descending,
            if ($s eq "title") then $title else() ascending,
            if ($s eq "date") then $aw_date else() descending
          return <ark>{$ark}</ark>
}</results>