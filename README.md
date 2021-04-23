# azblob-ingestion-filechecker
An easy tool to get a quick insight on files missing between two different ingestion stages using Azure Blob Storage accounts. Supports different file extensions and preffix filtering.

## Set up
Open *ingestion-checker.ps1* and set the following:
``` Powershell
$SOURCEstorageAccount = "Storage account name for source stage"
$SOURCEstorageKey = "Storage key for source storage account"
$SOURCEcontainer = "Blob container name for source storage account"
$SOURCEbasePath = "Preffix filter for files"

$DESTINATIONstorageAccount = "Storage account name for destination stage"
$DESTINATIONstorageKey = "Storage key for destination storage account"
$DESTINATIONcontainer = "Blob container name for destination storage account"
$DESTINATIONbasePath = "Preffix filter for files"

& pipenv run python check.py source.tsv destination.tsv <Source-File-Extension> <Destiny-File-Extension> > failed.txt
# Example: & pipenv run python check.py source.tsv destination.tsv xls parquet > failed.txt
```
## Running
Just run *./ingestion-checker.ps1* script. It will capture the list of files for your both stages and will perform and a comparison between them using *check.py* python script. Any discrepancies found will be annotated in *failed.txt* file.
## Notes
The python script will be launched using your python virtual environment (*pipenv*) (*sys* it's the only imported library)
