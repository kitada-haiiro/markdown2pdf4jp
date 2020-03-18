FROM pandoc/latex:latest

RUN tlmgr update --self && tlmgr install latexmk

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]