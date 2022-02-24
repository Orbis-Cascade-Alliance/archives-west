import module namespace aw = "https://archiveswest.orbiscascade.org";

for $d in (1 to 47)
  let $db := 'eads' || $d
  return <eads>{
    for $ead in db:open($db)/ead
      return
        if (not(count($ead/eadheader/filedesc/publicationstmt/date[@type="archiveswest"]) eq 1)) then <ead>{aw:get_ark($ead)}</ead> else()
  }</eads>