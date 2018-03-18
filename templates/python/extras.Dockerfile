{% for dep_group in extra_deps %}RUN pip install -U {{ dep_group|join(' ') }} --retries 30
{% endfor %}