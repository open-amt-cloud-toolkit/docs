FROM squidfunk/mkdocs-material@sha256:ce587cbffd5283056df4a84bd3f2eb0c54f0031b1789844dcaf6ac53da0fd52c

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
