<arks>
{
  for $ead in db:open('index-brief')/eads/ead[not(title/text())]
    return $ead
}
</arks>