(: Return all repository EADs from the production brief index :)
import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $a as xs:string external;
declare variable $d as xs:string external;
declare variable $s as xs:string external;

let $arks := tokenize($a, '\|')
return <results>{
  for $db_id in tokenize($d, '\|')
    for $ead in db:open('index-brief-prod')/eads[@db=$db_id]/ead
      let $ark := string($ead/@ark)
      let $title := string($ead/title)
      let $aw_date := string($ead/date)
      where not($ark="") and (empty($arks) or $ark=$arks)
        order by
          if ($s eq "title") then $title else() ascending,
          if ($s eq "date") then $aw_date else() descending
        return <ark>{$ark}</ark>
}</results>