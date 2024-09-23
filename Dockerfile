FROM squidfunk/mkdocs-material@sha256:22a429f602f2f616ff12ddc19bdcaae5f2096086a79c529fddd5472bdcb46165

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
