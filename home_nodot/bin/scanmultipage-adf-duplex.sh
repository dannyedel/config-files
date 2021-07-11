#!/bin/bash

TMPDIR=
# FIXME TRAP

set -evx

OUTPUTDIR="$(pwd)"

TMPDIR=$(mktemp -d)
cd ${TMPDIR}

TIMESTAMP=$(date +%Y-%m-%d__%H-%M-%S)

BASENAME="scan_${TIMESTAMP}"

SCANOPTS="-vvv --mode color --resolution 300 --source ADF \
	--format=tiff --batch=${BASENAME}_%03d.tiff"
OCROPTS="--language=deu --deskew --rotate-pages --rotate-pages-threshold 10 --clean"
CONVERTOPTS="-fuzz 1% -trim +repage"

if [[ -n "$1" ]] ; then
	if [[ -n "$SIMPLENAME" ]] ; then
		PDFNAME="$1.pdf"
	else
		PDFNAME="$1__${BASENAME}.pdf"
	fi
else
	PDFNAME=${BASENAME}.pdf
fi


# Scan forward
scanimage ${SCANOPTS} --batch-start 1 --batch-increment 2

COUNT=$(echo ${BASENAME}_*.tiff | wc -w)

echo "I got $COUNT pages"
echo "Insert reverse now and press enter"
read

PAGENUM=$((2*$COUNT))

scanimage ${SCANOPTS} --batch-start $PAGENUM --batch-increment -2 --batch-count $COUNT

convert ${BASENAME}_*.tiff ${CONVERTOPTS} pdf:- | \
	ocrmypdf ${OCROPTS} \
	--title "${PDFNAME}" \
	- ${PDFNAME}
mv -vi ${PDFNAME} "${OUTPUTDIR}/"
rm -vf ${BASENAME}_*.tiff

rmdir ${TMPDIR}
