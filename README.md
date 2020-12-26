
# discord.py Dockerfiles

This is the repo that stores generated Dockerfiles for the [gorialis/discord.py](https://hub.docker.com/r/gorialis/discord.py/) Docker repository.

You can generate Dockerfiles by using Python 3.9, installing `requirements.txt` with `pip install -U -r requirements.txt` and then simply running `generate.py`.

Components of the Dockerfiles are stored in `templates/`. Generation configuration is stored in `config.yml`.

I do not own the `discord.py` library. These Dockerfiles, and uploaded respective images, are provided for convenience only.

The discord.py library can be viewed [here](https://github.com/Rapptz/discord.py). It is available under the [MIT License](https://github.com/Rapptz/discord.py/blob/async/LICENSE).

While the Dockerfile templates, generated Dockerfiles and `generate.py` script are my own property and therefore subject to the [MIT License](https://github.com/Gorialis/discord.py-docker/blob/master/LICENSE), the dependencies installed in built images may be subject to their own licenses.
Please check you have read and understood those respective licenses before using the libraries in your own projects.
