FROM squidfunk/mkdocs-material@sha256:0d4e6877f5e2204d4e3da97bf858df075ecc39eae062ed05366c8b5b895a1131

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
