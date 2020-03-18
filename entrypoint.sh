#!/bin/ash
set -e
set -o pipefail

if [[ -n "$TOKEN" ]]; then
    GITHUB_TOKEN=$TOKEN
fi

if [[ -z "$OUTPUT_BRANCH" ]]; then
    OUTPUT_BRANCH="output"
fi

if [[ -z "$BUILD_DIR" ]]; then
    BUILD_DIR="."
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
    echo "Set the GITHUB_TOKEN env variable."
    exit 1
fi

if [[ -z "$GITHUB_REPOSITORY" ]]; then
    echo "Set the GITHUB_REPOSITORY env variable."
    exit 1
fi
main() {
    echo "ok"
    ls
    tlmgr --version
    pandoc test/main.md -o hoge.pdf --pdf-engine=lualatex -V documentclass=ltjsarticle -V luatexjapresetoption=ms
}

main "$@"