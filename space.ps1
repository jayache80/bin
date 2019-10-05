$totaltimer = [system.diagnostics.stopwatch]::StartNew()
$timer = [system.diagnostics.stopwatch]::StartNew()
$totalsize = [long]0
Get-ChildItem -File -Recurse -Force -ErrorAction SilentlyContinue | % {
    $totalsize += $_.Length;
    if ($timer.Elapsed.TotalSeconds -gt 2) {
        Write-Host "Current file:"
        Write-Host $_.FullName
        $totaltime = "{0:n2}" -f $totaltimer.Elapsed.TotalSeconds
        Write-Host "Elapsed time: ${totaltime} seconds"
        $sizegb = "{0:n3}" -f ($totalsize/1Gb)
        Write-Host "Size so far: ${sizegb}GB"
        $timer.Reset()
        $timer.Start()
    }
}
Write-Host "Complete!"
$totaltime = "{0:n2}" -f $totaltimer.Elapsed.TotalSeconds
Write-Host "Total elapsed time: ${totaltime} seconds"
$sizegb = "{0:n3}" -f ($totalsize/1Gb)
Write-Host -NoNewLine "total size is ${sizegb}GB"
