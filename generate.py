
from datetime import datetime
from itertools import chain, product
from jinja2 import Environment, FileSystemLoader
from os import listdir, makedirs
from yaml import safe_load

env = Environment(loader=FileSystemLoader('templates'))

# easy formatting for the readmes
env.filters['inline_codeblock'] = lambda m: ', '.join(['`{}`'.format(x) for x in m if x])
env.filters['unchain'] = lambda m: list(chain(*m))

dockerfile_template = env.get_template('generic.Dockerfile')

base_templates = {x: env.get_template('base_include/{}'.format(x)) for x in listdir('templates/base_include')}
dist_templates = {x: env.get_template('dist_include/{}'.format(x)) for x in listdir('templates/dist_include')}

with open('config.yml', 'rb') as fp:
    config = safe_load(fp)

now = datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S UTC')

pythons = config['python_versions'].items()
distros = config['distros'].items()
checkouts = config['checkouts'].items()
extra_deps = config['extra_deps']

tag_set = []

for py, distro, checkout in product(pythons, distros, checkouts):
    # format the tags together
    tags = ['-'.join(filter(None, map(str, x))) for x in product(py[1], distro[1], checkout[1])]

    # push this set of tags into the list for the larger readme
    tag_set.append(tags)

    # select the primary tag
    primary = tags[0]

    # render the dockerfile
    print("rendering dockerfile for {}".format(primary))

    dockerfile = dockerfile_template.render(distro=distro[0], python_version=py[0], now=now,
                                            checkout=checkout[0], extra_deps=extra_deps,
                                            primary=primary, tags=tags)

    # render the dockerfile dist includes
    print("rendering dist includes for {}".format(primary))

    dist_includes = {
        x: y.render(primary=primary, tags=tags, now=now, extra_deps=extra_deps)
        for x, y in dist_templates.items()
    }

    # make the dir
    print("making dir for {}".format(primary))
    makedirs('dockerfiles/{}'.format(primary), exist_ok=True)

    # push the files
    print("writing files for {}".format(primary))

    for x, y in dist_includes.items():
        with open("dockerfiles/{}/{}".format(primary, x), "w", encoding="utf8") as fp:
            fp.write(y)

    with open("dockerfiles/{}/Dockerfile".format(primary), "w", encoding="utf8") as fp:
        fp.write(dockerfile)

# render the base includes to be in dockerfiles/
print("rendering base includes")

base_includes = {
    x: y.render(builds=tag_set, extra_deps=extra_deps, now=now)
    for x, y in base_templates.items()
}

for x, y in base_includes.items():
    with open("dockerfiles/{}".format(x), "w", encoding="utf8") as fp:
        fp.write(y)
