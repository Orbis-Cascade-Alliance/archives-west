declare variable $t as xs:string external;
declare variable $d as xs:string external;
let $types := tokenize($t, '\|')
return <terms db="{$d}">{
  for $terms in db:open('eads' || $d)//controlaccess/*[local-name()=$types]
    group by $text := normalize-space(translate($terms, '&#160;', ' '))
    where not($text="")
      return
        <term text="{$text}">{
          for $ark in distinct-values($terms/ancestor::ead/eadheader/eadid/@identifier)
            return <ark>{$ark}</ark>
          }
        </term>
}</terms>
