(: Produce a report of brief records with empty titles :)
<arks>
{
  for $ead in db:get('index-brief')/eads/ead[not(title/text())]
    return $ead
}
</arks>