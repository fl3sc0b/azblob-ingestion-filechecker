import sys

ingest_file = sys.argv[1]
staging_file = sys.argv[2]
ingest_file_format = sys.argv[3]
staging_file_format = sys.argv[4]

with open(ingest_file, encoding='utf-8') as f:
    ingest = [line.split('\t')[3].replace('.' + ingest_file_format, '') for line in f.readlines()]

with open(staging_file, encoding='utf-8') as f:
     staging = []
     for line in f.readlines():
         pathSplit = line.split('\t')[3].split('/')
         if (len(pathSplit) > 6):
             fileName = pathSplit[6].replace('.' + staging_file_format, '')
             staging.append(fileName)

diff = list(set(ingest) - set(staging))

print('\n'.join([f"{d}" for d in diff]))