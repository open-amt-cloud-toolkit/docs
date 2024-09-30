FROM squidfunk/mkdocs-material@sha256:8e8b333257d2a5866a5b20809440eec360cbe6a54dbee70aaacd45e95fc06cbb

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
