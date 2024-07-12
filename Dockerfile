FROM squidfunk/mkdocs-material@sha256:257eca88da7f42242cd05e8cebf6d10ebd079edc207b089ad3f4f1ad107b0348

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
