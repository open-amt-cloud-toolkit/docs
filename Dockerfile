FROM squidfunk/mkdocs-material@sha256:2c2802b4d26154eb2c30238ba8ed3aab3a6276009334fd99613e4c01e97cd420

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
