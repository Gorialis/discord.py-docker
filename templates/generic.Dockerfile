{% include 'WARNING' %}
{% extends 'distro/{}.Dockerfile'.format(distro) %}
{% block labels -%}
{% include 'LABEL' %}
{%- endblock %}
{% block python_setup -%}

# update pip if it's out of date
RUN pip install -U pip --retries 30

# extras
{% include 'python/extras.Dockerfile' %}
{% if checkout == '' -%}
{% include 'python/discord.py-pypi.Dockerfile'.format(source) %}
{%- else -%}
{% include 'python/discord.py-git.Dockerfile'.format(source) %}
{%- endif %}
{%- endblock %}