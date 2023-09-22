#!/bin/bash

URL=$1
DIR="$HOME/cs/leetcode"
TEMP="temp.html"

curl -s "$URL" -o "$TEMP"

tail -n 1 "$TEMP" > "${TEMP}.tmp"
mv "${TEMP}.tmp" "$TEMP"

TITLE=$(awk 'BEGIN{RS="\","; FS="title\":\""}NF>1{print $NF; exit}' "$TEMP")
TITLESLUG=$(awk 'BEGIN{RS="\","; FS="titleSlug\":\""}NF>1{print $NF; exit}' "$TEMP")
DIFFICULTY=$(awk 'BEGIN{RS="\","; FS="difficulty\":\""}NF>1{print $NF; exit}' "$TEMP")
CATEGORY=$(awk 'BEGIN{RS="\"}"; FS="categoryTitle\":\""}NF>1{print $NF; exit}' "$TEMP")
ID=$(awk 'BEGIN{RS="\","; FS="questionFrontendId\":\""}NF>1{print $NF; exit}' "$TEMP")

FILE_PATH="${DIR}/${TITLESLUG}.py"

echo "# ${ID}. ${TITLE}" > "$FILE_PATH"
echo "# Difficulty: ${DIFFICULTY}, Category: ${CATEGORY}" >> "$FILE_PATH"
echo "File createed at: ${FILE_PATH}"

rm "$TEMP"
