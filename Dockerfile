FROM squidfunk/mkdocs-material@sha256:d485eb6e9ca02fa8158311e55595c344eb01db5587a7b2c35560c13cb906e3cd

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
