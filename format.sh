#!/bin/bash

set -e

if command -v typstyle >/dev/null 2>&1; then
    for file in $(find ./ -type f -name '*.typ'); do
        if [ -f "$file" ]; then
            echo $file && typstyle -l 100 -t 2 --wrap-text --no-reorder-import-items --timing -i "$file"
        fi
    done
fi
