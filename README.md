# markdown2pdf4jp
![build](https://github.com/kitada-haiiro/markdown2pdf4jp/workflows/build/badge.svg?branch=master)

A Github action to automatically convert the markdown to PDF.


## Usage

```
on: push
name: convert and deploy
jobs:
  build:
    name: kitada-haiiro/markdown2pdf4jp
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: kitada-haiiro/markdown2pdf4jp
      uses: kitada-haiiro/markdown2pdf4jp@master
      env:
        PREVIEW_BRANCH: preview
        BUILD_DIR: .
        TOKEN: ${{ secrets.TOKEN }}
        args: >-
            -V luatexjapresetoption=ms
            -V documentclass=ltjsarticle
```

