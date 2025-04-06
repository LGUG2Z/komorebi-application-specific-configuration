set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

sort:
    jq -f filter.jq .\applications.json > .\applications.sorted.json
    mv .\applications.sorted.json .\applications.json -Force
