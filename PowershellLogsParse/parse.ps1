Get-Content .\test.log | Select-String -Pattern '(\d+-\d\d-\d\d \d\d:\d\d:\d\d).*(afid=\d+)' | % {"$($_.matches.groups[1]) : $($_.matches.groups[2])"}
