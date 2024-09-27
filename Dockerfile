FROM squidfunk/mkdocs-material@sha256:7aea3592488c021f1391fe2259ea20d6253d705a7acab17581c0a0104c7ce308

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
