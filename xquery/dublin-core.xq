(: Output DC records for OAI-PMH harvesting :)
import module namespace aw = "https://archiveswest.orbiscascade.org";
declare variable $d as xs:string external;
declare variable $a as xs:string external;
let $db_ids := tokenize($d, '\|')
let $arks := tokenize($a, '\|')
return <records>{
  for $db_id in $db_ids
    let $db := 'eads' || $db_id
    for $ead in db:get($db)/ead[eadheader/eadid/@identifier=$arks]
      let $ark := aw:get_ark($ead)
      let $title := aw:get_title($ead)
      let $date := aw:get_date($ead)
      let $creators := $ead/archdesc/did/origination/*/text()
      let $subjects := $ead/archdesc/controlaccess/controlaccess/subject[@source="lcsh"]/text()
      let $languages := $ead/archdesc/did/langmaterial/language/text()
      let $abstract := aw:get_abstract($ead)
      let $extent := aw:concat_children($ead/archdesc/did/physdesc/extent, '; ')
      let $rights := aw:get_rights($ead)
      return
      <record>
        <db>{$db_id}</db>
        <ark>{$ark}</ark>
        <title>{$title}</title>
        <date>{$date}</date>
        <creators>{
          for $creator in $creators
            return <creator>{normalize-space($creator)}</creator>
        }</creators>
        <subjects>{
          for $subject in $subjects
            return <subject>{normalize-space($subject)}</subject>
        }</subjects>
        <languages>{
          for $language in $languages
            return <language>{normalize-space($language)}</language>
        }</languages>
        <abstract>{$abstract}</abstract>
        <extent>{$extent}</extent>
        <rights>{$rights}</rights>
      </record>
}</records>