FROM squidfunk/mkdocs-material@sha256:a2e3a31c00cfe1dd2dae83ba21dbfa2c04aee2fa2414275c230c27b91a4eda09

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
