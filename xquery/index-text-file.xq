import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $d as xs:string external;
declare variable $f as xs:string external;
declare variable $s as xs:string external;
let $stopwords := tokenize($s, '\|')
let $ead := doc('eads' || $d || '/' || $f)/ead 
let $ark := aw:get_ark($ead)
let $title := aw:remove_stopwords(ft:tokenize(aw:get_title($ead)), $stopwords)
let $aw_date := aw:get_aw_date($ead)
let $tokens := aw:remove_stopwords(ft:tokenize(string-join($ead//text(), ' ')), $stopwords)
let $result := <ead db="{$d}" ark="{$ark}">
  <title>{$title}</title>
  <date>{$aw_date}"</date>
  <tokens>{$tokens}</tokens>
</ead>
return insert node $result as last into db:open('index-text')/eads[@db=$d], db:optimize('index-text')