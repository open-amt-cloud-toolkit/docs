FROM squidfunk/mkdocs-material@sha256:f9cb76de2e0d6c31f98227839c299847c549459291b335f48828d60ff8b87059

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
