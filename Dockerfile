FROM squidfunk/mkdocs-material@sha256:2a703999163cdb8257a85849fb2d39914a82587769f95c297bb3f01acf72a609

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
