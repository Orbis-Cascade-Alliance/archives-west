xquery version "3.1" encoding "utf-8";

module namespace aw = "https://archiveswest.orbiscascade.org";

declare function aw:concat_children($parent as node()*, $delim as xs:string) as xs:string {
  let $string := normalize-space(string-join($parent/node()[not(self::processing-instruction()) and not(self::comment())], $delim))
  return $string
};

declare function aw:get_ark($ead as node()*) as xs:string {
  let $ark := normalize-space($ead/eadheader/eadid/@identifier)
  return $ark
};

declare function aw:get_title($ead as node()*) as xs:string {
  let $title := aw:concat_children($ead/archdesc/did/unittitle, ' ')
  return $title
};

declare function aw:get_date($ead as node()*) as xs:string {
  let $date := normalize-space($ead/archdesc/did/unitdate[1])
  return $date
};

declare function aw:get_aw_date($ead as node()*) as xs:string {
  let $aw_date := normalize-space($ead/eadheader/filedesc/publicationstmt/date[@type="archiveswest"]/@normal)
  return $aw_date
};

declare function aw:get_title_with_date($ead as node()*) as xs:string {
  let $title := string-join((aw:get_title($ead), aw:get_date($ead))[. != ''], ', ')
  return $title
};

declare function aw:get_abstract($ead as node()*) as xs:string {
  let $abstract := aw:concat_children($ead/archdesc/did/abstract, ' ')
  return $abstract
};