FROM squidfunk/mkdocs-material

RUN pip install --no-cache-dir \
  mkdocs-render-swagger-plugin mkdocs-macros-plugin mkdocs-mermaid2-plugin mkdocs-img2fig-plugin

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
