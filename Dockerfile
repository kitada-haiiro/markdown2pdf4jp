FROM pandoc/latex:latest

RUN tlmgr update --self --all && tlmgr install collection-langjapanese

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]