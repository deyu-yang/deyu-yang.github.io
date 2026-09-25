#!/bin/sh
# Make web versions of gallery photos for /photography/.
#
# For each original photo in /in that has no web version in /out yet:
#   1. auto-orient, resize to 2000px on the long edge, JPEG quality 85
#   2. drop ALL metadata (GPS, camera serial number, maker notes, ...)
#   3. copy back only shooting settings and dates from the original
#   4. write a unified creator / copyright notice (EXIF, IPTC, XMP);
#      the copyright year is the year the photo was taken
# Output names are lowercase .jpg, e.g. DSCF7765.JPG -> dscf7765.jpg.
#
# Runs inside the al-folio Docker image (it has ImageMagick and Perl).
# ExifTool is not in the image: download the source release from
# https://github.com/exiftool/exiftool (exiftool.org may be unreachable)
# and mount its folder as /tools.
#
# Usage on Windows (PowerShell, from the project root):
#   docker run --rm `
#     -v "<originals folder>:/in:ro" `
#     -v "${PWD}\assets\img\photography:/out" `
#     -v "<exiftool folder>:/tools:ro" `
#     -v "${PWD}\bin:/scripts:ro" `
#     --entrypoint sh amirpourmand/al-folio:latest /scripts/photo-web-version.sh
#
# On macOS use the same command with "\" line breaks and "/" paths.

set -e
ET="perl /tools/exiftool"
AUTHOR="Deyu Yang"

for src in /in/*; do
  case "$src" in
    *.jpg|*.JPG|*.jpeg|*.JPEG|*.heic|*.HEIC) ;;
    *) continue ;;
  esac
  base=$(basename "$src")
  name=$(echo "${base%.*}" | tr 'A-Z' 'a-z')
  out="/out/$name.jpg"
  if [ -e "$out" ]; then
    echo "skip: $name.jpg (already exists)"
    continue
  fi

  year=$($ET -s3 -d %Y -DateTimeOriginal "$src")
  [ -n "$year" ] || year=$(date +%Y)
  notice="© $year $AUTHOR. All rights reserved."

  convert "$src" -auto-orient -resize '2000x2000>' -strip \
    -quality 85 -sampling-factor 4:2:0 -interlace JPEG "$out"

  $ET -q -overwrite_original -tagsFromFile "$src" \
    -EXIF:Make -EXIF:Model -EXIF:LensMake -EXIF:LensModel \
    -EXIF:FocalLength -EXIF:FocalLengthIn35mmFormat -EXIF:FNumber -EXIF:ExposureTime \
    -EXIF:ISO -EXIF:ExposureProgram -EXIF:ExposureCompensation \
    -EXIF:DateTimeOriginal -EXIF:CreateDate '-EXIF:OffsetTime*' -EXIF:ColorSpace \
    "$out"

  $ET -q -overwrite_original -codedcharacterset=utf8 \
    -EXIF:Artist="$AUTHOR" -EXIF:Copyright="$notice" \
    -IPTC:By-line="$AUTHOR" -IPTC:CopyrightNotice="$notice" \
    -XMP-dc:Creator="$AUTHOR" -XMP-dc:Rights="$notice" -XMP-xmpRights:Marked=True \
    "$out"

  echo "done: $name.jpg ($year)"
done

echo
echo "Check that no sensitive metadata is left (no output below = clean):"
$ET -q -if '$SerialNumber or $InternalSerialNumber or $GPSLatitude or $MakerNotes' \
  -p '$FileName STILL HAS SENSITIVE DATA' /out/*.jpg || true
