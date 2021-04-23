$SOURCEstorageAccount = "Storage account name for source stage"
$SOURCEstorageKey = "Storage key for source storage account"
$SOURCEcontainer = "Blob container name for source storage account"
$SOURCEbasePath = "Preffix filter for files"

$DESTINATIONstorageAccount = "Storage account name for destination stage"
$DESTINATIONstorageKey = "Storage key for destination storage account"
$DESTINATIONcontainer = "Blob container name for destination storage account"
$DESTINATIONbasePath = "Preffix filter for files"

Remove-Item .\source.tsv -ErrorAction SilentlyContinue
Remove-Item .\destination.tsv -ErrorAction SilentlyContinue
Remove-Item .\failed.txt -ErrorAction SilentlyContinue

Write-Host "`n`nIngestion Checker. Compare files w/o extension between SOURCE and DESTINATION"
Write-Host "-----------------------------------------------------------------------------"

Write-Host "`nLoading SOURCE files..." -ForegroundColor Green

az storage blob list --container-name $SOURCEcontainer `
                     --account-name $SOURCEstorageAccount `
                     --account-key $SOURCEstorageKey `
                     --auth-mode key `
                     --output tsv `
                     --prefix $SOURCEbasePath `
                     --num-results * | Out-File -append source.tsv -Encoding ascii

Write-Host "`nLoading DESTINATION files..." -ForegroundColor Red

az storage blob list --container-name $DESTINATIONcontainer `
                     --account-name $DESTINATIONstorageAccount `
                     --account-key $DESTINATIONstorageKey `
                     --auth-mode key `
                     --output tsv `
                     --prefix $DESTINATIONbasePath `
                     --num-results * | Out-File -append destination.tsv -Encoding ascii

Write-Host "`nComparing files..." -ForegroundColor Yellow
& pipenv run python check.py source.tsv destination.tsv xls parquet > failed.txt
