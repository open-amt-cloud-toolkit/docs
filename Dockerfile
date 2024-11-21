FROM squidfunk/mkdocs-material@sha256:ef0b45e758c46f02e1d7c9662435e2de6de143c61eb1af1deec24c22ec79649b

COPY ./requirements.txt ./

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
