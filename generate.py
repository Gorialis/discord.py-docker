# -*- coding: utf-8 -*-

"""
MIT License

Copyright (c) 2018 Devon "Gorialis" R

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""

from datetime import datetime, UTC
from itertools import chain, product
from jinja2 import Environment, FileSystemLoader
from os import makedirs, path, walk
from yaml import safe_load

import re


with open('config.yml', 'rb') as fp:
    config = safe_load(fp)

env = Environment(loader=FileSystemLoader('templates'))

mktag = lambda *x: '-'.join(filter(None, map(str, x))) or 'latest'

def get_variations():
    py_v = config['python_versions']
    distros = config['distros']
    checkouts = config['checkouts']
    stages = config['stage_types']

    yield from product(py_v.items(), distros.items(), checkouts.items(), stages.items())

def simplify_config_dict(d):
    return {
        k: [v[0], ""] if "" in v and v[0] != "" else [v[0]]
        for k, v in d.items()
    }

def get_variations_short():
    py_v = simplify_config_dict(config['python_versions'])
    distros = simplify_config_dict(config['distros'])
    checkouts = simplify_config_dict(config['checkouts'])
    stages = simplify_config_dict(config['stage_types'])

    yield from product(py_v.items(), distros.items(), checkouts.items(), stages.items())

def get_tags(args):
    py_v, distro, checkout, stage = args
    return list(product(py_v[1], distro[1], checkout[1], stage[1]))

# functions for template context
extension_funcs = {
    'inline_codeblock': lambda m: ', '.join(['`{}`'.format(x) for x in m if x]),
    'unchain': lambda m: list(chain(*m)),
    'mktag': mktag,
    'mktag_l': lambda x: mktag(*x),
    'product': product,
    'list': list,
    'len': len,
    'get_variations': get_variations,
    'variations': list(get_variations()),
    'get_variations_short': get_variations_short,
    'variations_short': list(get_variations_short()),
    'get_tags': lambda *x: get_tags(x),
    'get_tags_l': get_tags,
    'tags': list(map(get_tags, get_variations())),
    'enquote': lambda x: f'"{x}"'
}

env.filters.update(**extension_funcs)
env.globals.update(**extension_funcs)

now = datetime.now(UTC).strftime('%Y-%m-%d %H:%M:%S UTC')

for root, dirs, files in walk('templates'):
    for name in dirs:
        makedirs(f'dockerfiles/{path.join(root, name)[10:]}', exist_ok=True)

    for name in files:
        real_name = path.join(root, name)[10:].replace('\\', '/')
        template = env.get_template(real_name)

        with open(f'dockerfiles/{real_name}', 'w', encoding='utf8', newline='\n') as fp:
            fp.write(template.render(now=now, **config))
