import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $q as xs:string external;
declare variable $a as xs:string external;
declare variable $d as xs:string external;
declare variable $s as xs:string external;
declare variable $f as xs:string external;

declare function local:in_title($title as xs:string, $term as xs:string) as xs:integer {
  let $contains := xs:integer(xs:boolean(contains(lower-case($title), lower-case($term))))
  return $contains
};

let $terms := tokenize($q, '\|')
let $arks := tokenize($a, '\|')
return <results>{
  for $db_id in tokenize($d, '\|')
    for $result in ft:search('eads' || $db_id, $terms, map{'mode':'any','fuzzy':$f})
      let $ead := $result/ancestor::ead
      let $ark := aw:get_ark($ead)
      let $title := aw:get_title($ead)
      let $aw_date := aw:get_aw_date($ead)
      where not($ark="") and (empty($arks) or $ark=$arks)
        group by $ark, $title, $aw_date
          let $contains_all := ft:contains(string-join($result, ' '), $terms, map{'mode':'all','fuzzy':'true'})
          where ($contains_all = xs:boolean(1))
            let $count := count($result)
            let $percent_exact := count(
              for $term in $terms
                return $result[contains(lower-case(.), lower-case($term))]
            ) div $count
            let $title_boost := fold-left(
              $terms,
              local:in_title($title, string(head($terms))),
              function($running_boost, $term) { 
                let $term_boost := local:in_title($title, string($term))
                return $running_boost + $term_boost
              }
            )
            let $phrase_boost := local:in_title($title, $q)
            let $score := ($count * 0.0001) + $percent_exact + $title_boost + $phrase_boost
            order by
              if ($s eq "score") then $score else() descending,
              if ($s eq "title") then $title else() ascending,
              if ($s eq "date") then $aw_date else() descending
            return <ark>{$ark}</ark>
}</results>