FROM squidfunk/mkdocs-material@sha256:d063d8460d449d5094da4b58c6e9b2aa8da869bb3a113a21401e0fe00bb8a628

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
