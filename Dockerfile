FROM squidfunk/mkdocs-material@sha256:ba73db5ab937632760a59742ba89e199ca6122cfad4ca21d1f27125fefa31a33

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
