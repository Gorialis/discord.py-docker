{% include 'WARNING_MD' %}

## Notice

The `rewrite` branch was merged into `master` on 2019-04-09, marking the end of the rewrite alpha stage. The `rewrite` tags will remain faithful to the old, now frozen, feature branch, so it is recommended to switch your containers to `master` to continue receiving development updates, or to switch to the new `pypi` tag.

## Tags and respective `Dockerfile` links

{% for version, distro, checkout, stage in variations_short -%}
-   {{ get_tags(version, distro, checkout, stage)|map('mktag_l')|inline_codeblock }} (*[{{ distro[0] }}](https://github.com/Gorialis/discord.py-docker/blob/master/dockerfiles/0_minimal/{{ distro[0] }}.Dockerfile):[{{ stage[1][0] }}](https://github.com/Gorialis/discord.py-docker/tree/master/dockerfiles/{{ stage[0] }}_{{ stage[1][0] }}/)*)
{% endfor %}
*({{ len(variations) }} variants, {{ len(unchain(tags)) }} tags)*

*See all the tags in the [full README](https://github.com/Gorialis/discord.py-docker/blob/master/dockerfiles/README.md)*

## Image variants

This image comes in few variants depending on your use case:

### `discord.py:minimal`

This is the base, and therefore smallest, image. It contains only `discord.py` with voice and docs support, including ffmpeg and youtube-dl.

### `discord.py:full`

This is the default image. This contains some precompiled common dependencies, and as such, is much larger than the base image.

These dependencies are:
-   {{ minor_deps.keys()|inline_codeblock }}

This can help reduce bot installation time as packages that would otherwise take a long time to compile or acquire are already installed.

### `discord.py:extras`

This image extends the `full` image with more dependencies:
-   {{ major_deps.keys()|inline_codeblock }}

This image is therefore the largest image and is only recommended if you use a large variety of these dependencies.

## Using this image

### Create a Dockerfile for your project

```dockerfile
FROM gorialis/discord.py

WORKDIR /app

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY . .

CMD ["python", "bot.py"]
```

You can use tags if you need specific versions:

```dockerfile
FROM gorialis/discord.py:3.6-alpine

WORKDIR /app

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY . .

CMD ["python", "bot.py"]
```

Then you can build your image and run it:
```sh
$ docker build -t my-bot .
$ docker run -it --rm --name my-running-bot my-bot
```

### Direct via console

If you are running one-time scripts, creating your own `Dockerfile` might be tedious. You can use this image directly from CLI like so:
```sh
$ docker run -it --rm --name my-bot -v $PWD:/app -w /app gorialis/discord.py:master python your-bot.py
```

You can also do this for tests:
```sh
$ docker run -it --rm --name my-tests -v $PWD:/app -w /app gorialis/discord.py:master pytest -vs
```

## Licensing

The `discord.py` library is available through the [MIT License](https://github.com/Rapptz/discord.py/blob/master/LICENSE) under copyright from [Rapptz](https://github.com/Rapptz).
Please visit the [original repository](https://github.com/Rapptz/discord.py) for more information.
