declare variable $t as xs:string external;
declare variable $d as xs:string external;
declare variable $f as xs:string external;
let $types := tokenize($t, '\|')
return <terms>{
  for $terms in doc('eads' || $d || '/' || $f)//controlaccess/*[local-name()=$types]
    group by $text := normalize-space(translate($terms, '&#160;', ' '))
    where not($text="")
      return
        <term>{$text}</term>
}</terms>
