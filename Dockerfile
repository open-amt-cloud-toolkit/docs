FROM squidfunk/mkdocs-material@sha256:9919d6ee948705ce6cd05e5bc0848af47de4f037afd7c3b91e776e7b119618a4

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
