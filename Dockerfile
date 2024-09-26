FROM squidfunk/mkdocs-material@sha256:08fbf586e0963725a58eec1ab067ab9b23b804601e0bc2ddb3ab85a2b1ceeb7f

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
