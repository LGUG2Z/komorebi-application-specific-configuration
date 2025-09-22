set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

sort:
    jq -f filter.jq .\applications.json > .\applications.sorted.json
    mv .\applications.sorted.json .\applications.json -Force


sort-mac:
    jq -f filter.jq applications.mac.json > applications.mac.sorted.json
    mv applications.mac.sorted.json applications.mac.json
