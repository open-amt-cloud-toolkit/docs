FROM squidfunk/mkdocs-material@sha256:7132ca3957c1fc325443579356fcc68696cd1aa54c715ce61228ea5e0b2d427a

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
