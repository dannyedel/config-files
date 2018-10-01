#!/bin/bash

TMPDIR=
# FIXME TRAP

set -evx

OUTPUTDIR="$(pwd)"

TMPDIR=$(mktemp -d)
cd ${TMPDIR}

TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)

BASENAME="scan_${TIMESTAMP}"

SCANOPTS="-vvv --mode color --resolution 300 --source ADF \
	--format=tiff --batch=${BASENAME}_%03d.tiff"
OCROPTS="--language=deu --deskew --rotate-pages"

scanimage ${SCANOPTS}

for TIFFNAME in ${BASENAME}_*.tiff ; do
	PDFNAME=${TIFFNAME/%.tiff/.pdf}
	# Send through ImageMagick and OCRmyPDF
	convert ${TIFFNAME} -fuzz 1% -trim +repage pdf:- | \
		ocrmypdf ${OCROPTS} \
		 --title "${PDFNAME}" \
		 - ${PDFNAME}
	mv -vi ${PDFNAME} "${OUTPUTDIR}/"
	rm -f ${TIFFNAME}
done

rmdir ${TMPDIR}
