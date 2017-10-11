#!/bin/sh
#
# format.sh
#
# run clang-format on each .c & .h file

if [ -z "${CLANG_FORMAT}" ]; then
    CLANG_FORMAT=clang-format
fi

a=`git ls-files '*.h' '*.c'`
for x in $a; do
    if [ $x != "config_in.h" ]; then
        $CLANG_FORMAT -i -style=file $x
    fi
done

m=`git ls-files -m`
if [ -n "$m" ]; then
    echo "Fromatting required when running clang-format version:"
    $CLANG_FORMAT -version
    echo
    echo "The following files needed formatting:"
    for f in $m; do
        echo $f
    done
    echo
    git diff
    exit 1
fi
exit 0
