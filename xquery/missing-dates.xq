import module namespace aw = "https://archiveswest.orbiscascade.org";

<arks>
{
  for $db in (1 to 48)
    for $ead in db:open('eads' || $db)/eads/ead[not(eadheader/filedesc/publicationstmt/date[@type="archiveswest"])]
      return aw:get_ark($ead)
}
</arks>