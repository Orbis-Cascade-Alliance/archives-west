(: Perform a full-text search of the production text index :)
import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $q as xs:string external;
declare variable $a as xs:string external;
declare variable $d as xs:string external;
declare variable $s as xs:string external;
declare variable $f as xs:string external;

declare function local:calculate_score($terms as xs:string+, $result as node()*, $title as xs:string, $basex_score as xs:double) as xs:double {
  let $boost := fold-left(
    $terms,
    local:calculate_boost(string(head($terms)), $result, $title),
    function($running_boost, $term) { 
      let $term_boost := local:calculate_boost($term, $result, $title)
      return $running_boost + $term_boost
    }
  )
  let $phrase_boost := local:in_string($result, string-join($terms, ' '))
  let $score := $basex_score + $boost + $phrase_boost
  return $score
};

declare function local:calculate_boost($term as xs:string, $result as node()*, $title as xs:string) as xs:double {
  let $in_title := local:in_string($title, $term)
  let $exact := local:in_string($result, $term)
  let $boost := $in_title + $exact
  return $boost
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