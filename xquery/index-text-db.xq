(: Add the EADs of a repository to the working text index :)
import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $d as xs:string external;
declare variable $s as xs:string external;
let $db := 'eads' || $d
let $stopwords := tokenize($s, '\|')
let $result := <eads db="{$d}">{
  for $ead in db:get($db)/ead 
    let $ark := aw:get_ark($ead)
    let $title := aw:remove_stopwords(ft:tokenize(aw:get_title($ead)), $stopwords)
    let $aw_date := aw:get_aw_date($ead)
    let $tokens := aw:remove_stopwords(ft:tokenize(string-join($ead//text(), ' ')), $stopwords)
    return <ead ark="{$ark}">
      <title>{$title}</title>
      <date>{$aw_date}"</date>
      <tokens>{$tokens}</tokens>
    </ead>
}</eads>
return db:add('text' || $d, $result, 'tokens'), db:optimize('text' || $d)