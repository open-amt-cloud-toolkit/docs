FROM squidfunk/mkdocs-material@sha256:badd1c2f82460953fec431cec750fdeb5853098ea9ec1e4ea6432ca3c5682a28

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
