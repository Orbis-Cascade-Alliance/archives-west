import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $d as xs:string external;
<eads>{
for $ead in db:open('eads' || $d)/ead
  let $ark := aw:get_ark($ead)
  let $title := aw:get_title_with_date($ead)
  let $date := aw:get_aw_date($ead)
  return <ead>
    <ark>{$ark}</ark>
    <title>{$title}</title>
    <date>{$date}</date>
  </ead>
}</eads>