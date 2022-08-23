(: Add specific EAD files to the working text indexes :)
import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $f as xs:string external;
declare variable $s as xs:string external;
declare variable $db_files as xs:string+ := tokenize($f, '\|');

let $stopwords := tokenize($s, '\|')
let $add_to_text := %updating function($db_files, $stopwords) {
  for $db_file in $db_files
    let $db_id := substring-before($db_file, ':')
    let $file := substring-after($db_file, ':')
    let $ead := doc('eads' || $db_id || '/' || $file)/ead 
    let $ark := aw:get_ark($ead)
    where not(db:get('text' || $db_id)/eads/ead[@ark=$ark])
      let $title := aw:remove_stopwords(ft:tokenize(aw:get_title($ead)), $stopwords)
      let $aw_date := aw:get_aw_date($ead)
      let $tokens := aw:remove_stopwords(ft:tokenize(string-join($ead//text(), ' ')), $stopwords)
      let $result := <ead ark="{$ark}">
        <title>{$title}</title>
        <date>{$aw_date}"</date>
        <tokens>{$tokens}</tokens>
      </ead>
     return insert node $result as last into db:get('text' || $db_id)/eads
  }
return updating $add_to_text($db_files, $stopwords), 

let $optimize_dbs := %updating function($db_files) {
  let $db_ids := distinct-values(
    for $db_file in $db_files
      return substring-before($db_file, ':')
  )
  for $db_id in $db_ids
    return db:optimize('text' || $db_id)
}
return updating $optimize_dbs($db_files)