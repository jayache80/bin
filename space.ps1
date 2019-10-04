$totalsize = [long]0
Get-ChildItem -File -Recurse -Force -ErrorAction SilentlyContinue | % {$totalsize += $_.Length}
$sizegb = "{0:n3}" -f ($totalsize/1Gb)
Write-Host -NoNewLine "total size is ${sizegb}GB"
