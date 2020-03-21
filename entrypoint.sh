#!/bin/ash
set -e
set -o pipefail

if [[ -n "$TOKEN" ]]; then
    GITHUB_TOKEN=$TOKEN
fi

if [[ -z "$PREVIEW_BRANCH" ]]; then
    PREVIEW_BRANCH="preview"
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

if [[ -z "$args" ]]; then
    ARGS=$args
fi

main() {
    echo "Starting print..."

    echo "Fetch"
    git config --global url."https://".insteadOf git://
    git config --global url."https://github.com/".insteadOf git@github.com:
    git submodule update --init --recursive

    version=$(tlmgr --version)
    remote_repo="https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
    remote_branch=$PREVIEW_BRANCH

    echo "Using $version"

    echo "converting..."
    cd $BUILD_DIR

    mkdir out

    pandoc test/main.md -o out/hoge.pdf --pdf-engine=lualatex $ARGS

    echo "Pushing articats to ${GITHUB_REPOSITORY}:$remote_branch"

    cd out
    git init
    git config user.name "GA"
    git config user.email "actions@users.noreplay.github.com"
    git add .

    git commit -m "Publishing"
    git push --force "${remote_repo}" master:${remote_branch}

    echo "All done."
}

main "$@"