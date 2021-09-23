
# Documentation for development of mkdocs-material documentation site

## Local Development (docker) (recommended):

`docker-compose -f "docker-compose.yml" up -d --build`

## Local Development (native)

In order to render and preview the site locally (without docker) you will need a few things to get started. 

1) You will need to install python and pip

2) After python is installed, you'll need the following python dependencies:
`pip install mkdocs`
`pip install mkdocs-material==7.3.0`
`pip install mkdocs-render-swagger-plugin`
`pip install mkdocs-mermaid2-plugin`

3) Once you have all the pre-reqs installed. You can simply run `mkdocs serve` and view the rendered content locally and makes changes to your documentation and preview them in realtime with a browser open. 
