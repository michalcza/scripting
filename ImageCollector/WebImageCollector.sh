#!/bin/ksh
# WIC.ksh - Web Image Collector
#
# WIC reads from a list of URLs and spiders each site recursively
# downloading images that match specified criteria (type, size).

#-----------------------------------------------------------------
# ENVIRONMENT CONFIGURATION
#-----------------------------------------------------------------

WORKDIR="C:/Downloads"    # Working directory
cd "$WORKDIR"
OUTPUT="$WORKDIR/output"    # Final output directory
URLS="$WORKDIR/url_list.txt"    # List of URLs
WGET="/usr/bin/wget"        # Wget executable
SIZE="+7k"            # Minimum image size to keep

TMPDIR1="$WORKDIR/tmp1"        # Temporary directory 1
TMPDIR2="$WORKDIR/tmp2"        # Temporary directory 2
TMPDIR3="$WORKDIR/tmp3"        # Temporary directory 3

if [ ! -d "$WORKDIR" ]
then
    mkdir "$WORKDIR"
    if [ ! -d "$WORKDiR" ]
    then
        echo "Download directory not found. Exiting..."
        exit 1
    fi
fi

if [ ! -d "$OUTPUT" ]
then
    mkdir "$OUTPUT"
    if [ ! -d "$OUTPUT" ]
    then
        echo "Cannot create $OUTPUT directory. Exiting..."
        exit 1
    fi
fi

if [ ! -f "$URLS" ]
then
    echo "URL list not found in $WORKDIR. Exiting..."
    exit 1
fi

for i in 1 2 3
do
    if [ -d "$WORKDIR/tmp$i" ]
    then
        rm -r "$WORKDIR/tmp$i"
        mkdir "$WORKDIR/tmp$i"
    else
        mkdir "$WORKDIR/tmp$i"
    fi
done

if [ ! -f "$WGET" ]
then
    echo "$WGET executable not found. Exiting..."
    exit 1
fi

#-----------------------------------------------------------------
# DOWNLOAD IMAGES
#-----------------------------------------------------------------

cat "$URLS" | while read URL
do
    echo "Processing $URL"

    DOMAIN=$(echo "$URL" | awk -F'/' '{print $3}')

    if [ ! -d "$OUTPUT/$DOMAIN" ]
    then
        cd "$TMPDIR1"
        mkdir "$OUTPUT/$DOMAIN"
        $WGET --http-user=your_username --http-passwd=your_password -r -l 0 -U Mozilla -t 1 -nd -A jpg,jpeg,gif,png,pdf "$URL" -e robots=off
        find "$TMPDIR1" -type f -size "$SIZE" -exec mv {} "$OUTPUT/$DOMAIN" ;
        cd "$WORKDIR"
    else
        echo "    $URL already processed. Skipping..."
    fi

    for i in 1 2 3
    do
        if [ -d "$WORKDIR/tmp$i" ]
        then
            rm -r "$WORKDIR/tmp$i"
            mkdir "$WORKDIR/tmp$i"
        else
            mkdir "$WORKDIR/tmp$i"
            fi
    done
done

#-----------------------------------------------------------------
# Remove empty download directories
#-----------------------------------------------------------------

cd "$OUTPUT"
find . -type d | fgrep "./" | while read DIR
do
    if [ `ls -R "$DIR" | wc -l | awk '{print $1}'` -eq 0 ]
    then
        rmdir "$DIR"
    fi
done

cd