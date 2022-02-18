import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $a as xs:string external;
declare variable $d as xs:string external;
declare variable $s as xs:string external;

let $arks := tokenize($a, '\|')
return <results>{
  for $db_id in tokenize($d, '\|')
    for $ead in collection('eads' || $db_id)/ead
      let $ark := aw:get_ark($ead)
      let $title := aw:get_title($ead)
      let $aw_date := aw:get_aw_date($ead)
      where not($ark="") and (empty($arks) or $ark=$arks)
        order by
          if ($s eq "title") then $title else() ascending,
          if ($s eq "date") then $aw_date else() descending
        return <ark>{$ark}</ark>
}</results>