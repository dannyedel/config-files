#!/bin/bash

TMPDIR=
# FIXME TRAP

set -evx

OUTPUTDIR="$(pwd)"

TMPDIR=$(mktemp -d)
cd ${TMPDIR}

TIMESTAMP=$(date +%Y-%m-%d__%H-%M-%S)

BASENAME="scan_${TIMESTAMP}"

PDFNAME=${BASENAME}.pdf

if [[ -n "$1" ]] ; then
	PDFNAME="$1__${BASENAME}.pdf"
fi
SCANOPTS="-vvv --mode color --resolution 300 --source Flatbed \
	--format=tiff --batch=${BASENAME}_%03d.tiff --batch-prompt"
OCROPTS="--language=deu --deskew --rotate-pages \
	--rotate-pages-threshold 9 --clean"
CONVERTOPTS="-fuzz 2% -trim +repage"

scanimage ${SCANOPTS}

convert ${BASENAME}_*.tiff ${CONVERTOPTS} pdf:- | \
	ocrmypdf ${OCROPTS} \
	--title "${PDFNAME}" \
	- "${PDFNAME}"
mv -vi "${PDFNAME}" "${OUTPUTDIR}/"
rm -vf ${BASENAME}_*.tiff

rmdir ${TMPDIR}
