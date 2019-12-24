# schlueter.github.io
A catalogue of personal projects I've worked on. It is dynamically assembled
and may be served as a static website. Initially I'll serve it with GitHub
Pages.

## Design
Templates for the index.html, page header and footer, and for singular posts are used to construct the site and are populated with the content of the posts.

## Building
`make build`

to assemble the application on your system

or

`make docker-build`

to assemble the application inside a container.

The containerized version may be run with `make docker-run` and then accessed via curl with `make curl`.

Building locally requires fgrep, jq, node, npm, and sed, while building with docker only requires docker, and curl if you want to run the curl command.
