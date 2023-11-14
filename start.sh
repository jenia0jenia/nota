#!/bin/bash
basedir=~/projects/nota
audiveris=~/projects/audiveris
nota=$basedir/nota
png=$basedir/png
pdf=$basedir/pdf
omr=$basedir/omr
xml=$basedir/xml
mid=$basedir/mid
MAX_FILESIZE=$(expr 5 \* 1024 \* 1024)

mkdir -p $pdf
cd $basedir/nota

makeRecognition() {
    x=$1
    filename="${x%.*}"

    echo "Reading file $x from $basedir/nota"

    FILESIZE=$(stat -c%s "$basedir/nota/$x")
    if [ "$FILESIZE" -gt "$MAX_FILESIZE" ] ; then
        echo "To big filesize"
        return 2
    fi;

    mkdir -p "$png/$filename"
    mkdir -p "$omr/$filename"
    mkdir -p "$xml/$filename"
    mkdir -p "$mid/$filename"

    {
    if [ ! -z "$(ls -A $mid/$filename)" ]; then
        echo "Skip $filename. $mid/$filename not empty!"
        return 1
    fi
    }

    echo "Start process..."

    echo pdftoppm $x "$png/$filename/$filename" -png
    pdftoppm $nota/$x "$png/$filename/$filename" -png

    echo convert "$png/$filename/*.png" "$pdf/$x"
    convert "$png/$filename/*.png" "$pdf/$x"

    cd $audiveris
    echo $audiveris/gradlew run -PcmdLineArgs="-batch,-export,-output,$omr/$filename,--,$pdf/$x"
    ./gradlew run -PcmdLineArgs="-batch,-export,-output,$omr/$filename,--,$pdf/$x"

    cd $omr/$filename
    for m in *.mxl; do
        midfilename="${m%.*}"

        echo unzip -o $m -d $xml/$filename
        unzip -o $m -d $xml/$filename

        echo mscore $omr/$filename/$m -o $mid/$filename/$midfilename.mid
        mscore $omr/$filename/$m -o $mid/$filename/$midfilename.mid
    done

    cd $basedir/nota
}

# Without argv
if [ $# -eq 0 ];
  then
    for x in *.pdf;
    do
        makeRecognition $x
    done

# With argv
  else
    i=1;
    for x in "$@";
    do
        makeRecognition $x
        if [ $? -eq 1 ];
        then
            continue
        fi
        i=$((i + 1));
    done
fi
