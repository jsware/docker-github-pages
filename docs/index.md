---
title: GitHub Pages Docker Image
layout: splash
header:
  overlay_image: /assets/images/philippe-oursel-06y6wukkSKg-unsplash.jpg
  overlay_filter: 0.25
  actions:
    - label: "<i class='fas fa-download'></i> Use now"
      url: "#usage"
    - label: "<i class='fab fa-docker'></i> View on Docker Hub"
      url: "https://hub.docker.com/r/jsware/github-pages"
    - label: "<i class='fab fa-github'></i> View on GitHub"
      url: "https://github.com/jsware/docker-github-pages"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com/photos/person-in-red-hoodie-standing-near-body-of-water-during-night-time-06y6wukkSKg)"
      
excerpt: >
  A Docker image with GitHub Pages dependencies included allowing you to host your GitHub Pages site locally during development.
---
# Introduction

## What is GitHub Pages

GitHub Pages hosts static websites. It could be about yourself, a project, or a business. GitHub Pages [prohibits](https://docs.github.com/en/pages/getting-started-with-github-pages/about-github-pages#prohibited-uses) use for running an online business, e-commerce site or anything primarily directed as commercial transactions or Software as a Service. For more information on GitHub Pages, see [GitHub Pages documentation](https://docs.github.com/en/pages).

This website is hosted using GitHub Pages.

### What is Jekyll

Jekyll is a framework, written in Ruby, to create static websites and blogs from plain text documents. GitHub Pages can use Jekyll. Jekyll plugins provide a mechanism to extend Jekyll functionality. GitHub Pages makes a limited number of Jekyll plugins available. See the GitHub Pages [depencency versions page](https://pages.github.com/versions/) for available Jekyll plugins. For more details on Jekyll, see the [Jekyll documentation](https://jekyllrb.com).

This website is built using Jekyll.

## What is Docker

Docker allows developers to build and test applications. In Docker, an image of everything required to run an application is packaged and used to create a standard container that runs in a virtual machine. For more information on Docker, see the [Docker documentation](https://www.docker.com).

The `jsware/github-pages` Docker image contains the correct versions of Ruby, Jekyll and plugins allowed by GitHub Pages.

This website is tested using Docker and the `jsware/github-pages` image.

# Local Development Environment

Every time you push your website modifications to GitHub, GitHub Pages will publish those changes. If you are not able to test your changes before publishing them, you could easily break the site. This becomes more important as your site grows.

![GitHub Pages in Docker](/assets/images/GitHub-Pages.gif)

This Docker image came about because I was not able to setup Ruby, Jekyll and plugins allowed by GitHub Pages. My MacBook Pro (Mid 2015) only runs macOS Monterey 12.7.6 (the latest). A common way of running Jekyll locally uses [Homebrew](http://brew.sh) package manager software. Unfortunately as of October 2024, Homebrew stopped supporting macOS Monterey 12.

So this Docker image was born.

## Prerequisites

Before using this image, you will need the following installed:

* [Docker Desktop](https://www.docker.com/products/docker-desktop/).
* Your favorite Text Editor like [Microsoft Code](https://code.visualstudio.com), [Notepad++](https://notepad-plus-plus.org) or similar.
* [GitHub Desktop](https://desktop.github.com/download/) for saving and pushing your files to GitHub.

# Usage

Once the above are installed and working, use the folowing command to start your GitHub Pages website (Replace `THINGS-LIKE-THIS` with your own values):

```bash
cd YOUR-WEBSITE-DIRECTORY

docker run --rm --interactive --tty --volume .:/home --pubish 4000:4000 jsware/github-pages
```

The command options are explained:
``` bash
docker run \            # Create and start a container.
  --rm \                # When the container stops, remove it to keep tidy.
  --interactive \       # Interactive mode shows the Jekyll build output.
  --tty \               # Connect the keyboard to the running container.
  --volume .:/home \    # Map the current directory . to /home in the container.
  --pubish 4000:4000 \  # Map port 4000 in the container to port 4000 on your local workstation.
  jsware/github-pages   # The name of the Docker image to use.
```

The above command uses verbose arguments. Shorter ones are available:

```bash
docker run --rm -it -v .:/home -p 4000:4000 jsware/github-pages
```
You might decide to create a short shell script such as follows so you can run that quickly and easily:

```bash
# Do this once...
echo "docker run --rm -it -v .:/home -p 4000:4000 jsware/github-pages" >serve.sh
chmod +x serve.sh

# Then run serve.sh whenever you want to start your website locally.
./serve.sh
```

If you store your Jekyll site in a `docs` subdirectory of your GitHub project, you can modify the `docker run` command:

```bash
docker run --rm -it -v ./docs:/home -p 4000:4000 jsware/github-pages
```

NB: You might get the following message because the container cannot find the `.git` repository information directory:

```
fatal: not a git repository (or any parent up to mount point /)
Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).
```

This is because only the `docs` subdirectory has been mounted within the container. I will change how the volume is mounted in the future to avoid the message if it becomes a problem.

### GitHub Repository Information

If your site includes GitHub information such as `site.github` then an environment variable called `JEKYLL_GITHUB_TOKEN` needs to be set to your GitHub access token:

**Don't store it in your repository for everyone to see!**

I recommend setting an environment variable `JEKYLL_GITHUB_TOKEN` with your access token text and then refer to it in configuration or when running commands:

```bash
docker run --rm -it -v .:/home -p 4000:4000 -e JEKYLL_GITHUB_TOKEN=$JEKYLL_GITHUB_TOKEN jsware/github-pages
```

### Docker Compose

If you wish, you could create a `docker-compose.yaml` file so the GitHub Pages application can be started using:

```bash
docker compose up
```

an example docker compose file is:

```yaml
services:
  github-pages:
    image: jsware/github-pages
    container_name: GitHub-Pages
    environment:
      JEKYLL_GITHUB_TOKEN: $JEKYLL_GITHUB_TOKEN
    ports:
      - "4000:4000"
    volumes:
      - ./docs:/home
    tty: true
```

*NB: In the above example, the `docker-compose.yaml` file lives in a GitHub parent directy with the website files stored in a docs subdirectory. Hence the volume is`./docs:/home`.*