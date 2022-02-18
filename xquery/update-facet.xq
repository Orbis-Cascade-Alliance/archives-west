declare variable $n as xs:string external;
declare variable $d as xs:string external;
declare variable $s as xs:string external;
declare variable $a as xs:string external;
let $db := 'facet-' || $n
let $term := db:open($db)//terms[@db=$d]/term[@text=$s]
return
  if (exists($term)) then
    insert node <ark>{$a}</ark> as last into $term
  else
    insert node <term text="{$s}"><ark>{$a}</ark></term> as last into db:open($db)//terms[@db=$d]