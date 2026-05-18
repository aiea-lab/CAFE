#!/bin/bash

readonly THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ATTEMPTS_DIR="$THIS_DIR/attempts"

function main() {
    set -e
    trap exit SIGINT

    mkdir -p "$ATTEMPTS_DIR"

    COUNT=1
    while [ -d "$ATTEMPTS_DIR/$COUNT" ]; do
        ((COUNT++))
    done

    mkdir "$ATTEMPTS_DIR/$COUNT"

    cp submission/solution.py $ATTEMPTS_DIR/$COUNT
    ./grader.py -s submission/ -t $ATTEMPTS_DIR/$COUNT

    echo "Created: $BASE_DIR/$COUNT"
    return $?
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

