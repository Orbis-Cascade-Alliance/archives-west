import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $f as xs:string external;
declare variable $s as xs:string external;
let $files := tokenize($f, '\|')
let $stopwords := tokenize($s, '\|')
let $add_to_text := %updating function($files, $stopwords) {
  for $file in $files
    let $db_id := substring-before($file, ':')
    let $filename := substring-after($file, ':')
    let $ead := doc('eads' || $db_id || '/' || $filename)/ead 
    let $ark := aw:get_ark($ead)
    let $title := aw:remove_stopwords(ft:tokenize(aw:get_title($ead)), $stopwords)
    let $aw_date := aw:get_aw_date($ead)
    let $tokens := aw:remove_stopwords(ft:tokenize(string-join($ead//text(), ' ')), $stopwords)
    let $result := <ead db="{$db_id}" ark="{$ark}">
      <title>{$title}</title>
      <date>{$aw_date}"</date>
      <tokens>{$tokens}</tokens>
    </ead>
   return insert node $result as last into db:open('index-text')/eads[@db=$db_id]
}
return updating $add_to_text($files, $stopwords), db:optimize('index-text')