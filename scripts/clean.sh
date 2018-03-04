#!/bin/sh

# run scrapy crawl liquor
cat ../out/liquor.json | jq -f filter_liquors.jq | jq -s '.' > cleaned_liquor.json

# https://docs.google.com/spreadsheets/d/16VvPjgdIhjlcoPatybiYJ1Dvr0Yw3h3i9JpwiUXVHDk/edit#gid=0
# convert ^ to json
cat ../out/cocktails.json | jq -f filter_cocktails.jq | jq -s '.' > cleaned_cocktails.json
