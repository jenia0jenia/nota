#!/bin/bash
basedir=~/projects/nota
audiveris=~/projects/audiveris
nota=$basedir/nota/
png=$basedir/png/
pdf=$basedir/pdf/
omr=$basedir/omr/
xml=$basedir/xml/
mid=$basedir/mid/

cd $basedir/nota

for x in *.pdf; do
    filename="${x%.*}"
    mkdir -p "$png/$filename"
    mkdir -p "$pdf"
    mkdir -p "$omr/$filename"
    mkdir -p "$xml/$filename"
    mkdir -p "$mid/$filename"

    echo pdftoppm $x "$png/$filename/$filename" -png
    pdftoppm $nota/$x "$png/$filename/$filename" -png

    echo convert "$png/$filename/*.png" "$pdf/$x"
    convert "$png/$filename/*.png" "$pdf/$x"

    echo $audiveris/gradlew run -PcmdLineArgs="-batch,-export,-output,$omr/$filename,--,$pdf/$x"
    cd $audiveris
    ./gradlew run -PcmdLineArgs="-batch,-export,-output,$omr/$filename,--,$pdf/$x"
    
    cd $omr/$filename
    for m in *.mxl; do
        unzip -o $m -d $xml/$filename
        midfilename="${m%.*}"
        echo mscore $omr/$filename/$m -o $mid/$filename/$midfilename.mid
        mscore $omr/$filename/$m -o $mid/$filename/$midfilename.mid
    done

    cd $basedir/nota
done
