FROM squidfunk/mkdocs-material@sha256:3f571e7f83702812ab63e73c912dfea762abecd12b3d9bae678211bb625ba9ad

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
