import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $q as xs:string external;
declare variable $a as xs:string external;
declare variable $d as xs:string external;
declare variable $s as xs:string external;
declare variable $f as xs:string external;

declare function local:calculate_score($db_id as xs:string, $terms as xs:string+, $results as node()*, $title as xs:string) as xs:float {
  let $count := xs:integer(count($results))
  let $boost := fold-left(
    $terms,
    local:calculate_boost(string(head($terms)), $results, $title, $count),
    function($running_boost, $term) { 
      let $term_boost := local:calculate_boost($term, $results, $title, $count)
      return $running_boost + $term_boost
    }
  )
  let $phrase_boost := local:in_title($title, string-join($terms, ' '))
  let $score := ($count * 0.0001) + $boost + $phrase_boost
  return $score
};

declare function local:calculate_boost($term as xs:string, $results as node()*, $title as xs:string, $count as xs:integer) as xs:float {
  let $in_title := local:in_title($title, $term)
  let $percent_exact := count($results[contains(lower-case(.), lower-case($term))]) div $count
  let $boost := $in_title + $percent_exact
  return $boost
};

declare function local:in_title($title as xs:string, $term as xs:string) as xs:integer {
  let $contains := xs:integer(xs:boolean(contains(lower-case($title), lower-case($term))))
  return $contains
};

let $terms := tokenize($q, '\|')
let $arks := tokenize($a, '\|')
return <results>{
  for $db_id in tokenize($d, '\|')
    for $result in ft:search('eads' || $db_id, $terms, map{'mode':'any word','fuzzy':$f})
      let $ead := $result/ancestor::ead
      let $ark := aw:get_ark($ead)
      let $title := aw:get_title($ead)
      let $aw_date := aw:get_aw_date($ead)
      where not($ark="") and (empty($arks) or $ark=$arks)
        group by $ark, $title, $aw_date, $db_id
          where ft:contains(string-join($result, ' '), $terms, map{'mode':'all words','fuzzy':$f})
            order by
              if ($s eq "score") then local:calculate_score($db_id, $terms, $result, $title) else() descending,
              if ($s eq "title") then $title else() ascending,
              if ($s eq "date") then $aw_date else() descending
            return <ark>{$ark}</ark>
}</results>