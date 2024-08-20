FROM squidfunk/mkdocs-material@sha256:a73e4bbbccb09e5374cef28ebe68511c166222274f8486b25ad467ec1f5e8bbe

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
