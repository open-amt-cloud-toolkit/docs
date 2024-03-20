FROM squidfunk/mkdocs-material

RUN pip install --no-cache-dir \
  mkdocs-render-swagger-plugin mkdocs-macros-plugin mkdocs-img2fig-plugin mkdocs-mermaid2-plugin mkdocs-git-committers-plugin-2 mkdocs-git-revision-date-localized-plugin

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
