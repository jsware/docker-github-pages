# Local GitHub Pages for Development

This Docker image contains a copy of ruby and the GitHub Pages [dependencies](https://pages.github.com/versions/).

To use this repository issue the following command from the directory where you are working on your GitHub Pages repository:

```
docker run --rm --interactive --tty --volume .:/home --pubish 4000:4000 --env JEKYLL_GITHUB_TOKEN=$JEKYLL_GITHUB_TOKEN jsware/github-pages
```

The image will start and server the GitHub Pages site from the current directory (mapped to `/home` in the container). When files are changed it will regenerate the site.

The same command can be run with shorter options:

```
docker run --rm -it -v .:/home -p 4000:4000 -e JEKYLL_GITHUB_TOKEN=$JEKYLL_GITHUB_TOKEN jsware/github-pages
```

If you do not need GitHub credentials for your repository, you may remove the `--env JEKYLL_GITHUB_TOKEN=$JEKYLL_GITHUB_TOKEN` argument.

These commands assume your GitHub token for Jekyll is in an environment variable called `JEKYLL_GITHUB_TOKEN`. You could use `--env-file` to specify an environment variable file instead.