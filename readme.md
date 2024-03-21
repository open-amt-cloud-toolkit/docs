
# Documentation for development of mkdocs-material documentation site

## Local Development (docker) (recommended):

`docker compose -f "docker-compose.yml" up -d --build`

## Local Development (native)

In order to render and preview the site locally (without docker) you will need a few things to get started. 

1) You will need to install python and pip

2) After python is installed, you'll need the following python dependencies:
- `pip install mkdocs`
- `pip install mkdocs-material==9.5.14`
- `pip install mkdocs-render-swagger-plugin`
- `pip install mkdocs-mermaid2-plugin`
- `pip install mkdocs-macros-plugin`
- `pip install mkdocs-img2fig-plugin`
- `pip install mkdocs-git-committers-plugin-2`
- `pip install mkdocs-git-revision-date-localized-plugin`

  **Single line command:** `pip install mkdocs mkdocs-material==9.5.14 mkdocs-render-swagger-plugin mkdocs-mermaid2-plugin mkdocs-macros-plugin mkdocs-img2fig-plugin mkdocs-git-committers-plugin-2 mkdocs-git-revision-date-localized-plugin`

3) Once you have all the pre-reqs installed. You can simply run `mkdocs serve` and view the rendered content locally and makes changes to your documentation and preview them in realtime with a browser open. 
