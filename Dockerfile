FROM squidfunk/mkdocs-material@sha256:257eca88da7f42242cd05e8cebf6d10ebd079edc207b089ad3f4f1ad107b0348

RUN pip install --no-cache-dir \
  git+https://github.com/bharel/mkdocs-render-swagger-plugin.git@e8b6996428e93dea1ddd0378ddc3e6391b078d7f \
  git+https://github.com/fralau/mkdocs-macros-plugin.git@4bfda0bd7efe070439aa5cecea3d3ca2d86375d2 \
  git+https://github.com/stuebersystems/mkdocs-img2fig-plugin.git@c618bce2dfed9a0e279dfdd5ad6930723e3fb157 \
  git+https://github.com/fralau/mkdocs-mermaid2-plugin.git@df11b49acac82499f5c2ea4480b75ddc7ca0e427

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
