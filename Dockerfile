FROM squidfunk/mkdocs-material@sha256:31eb7f7c86dc35e29ca5520e1826b3c7fd54ddd84adc20cb0a42f59d17aa912e

RUN pip install -r ./requirements.txt --require-hashes --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
