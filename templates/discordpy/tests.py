# -*- coding: utf8 -*-

"""
discord.py-docker test script

this script is used to determine if a container has built correctly or not
"""

import importlib
from pprint import pprint

import pytest
from pip._internal.operations.freeze import freeze

INSTALLED_PKGS = {
    x[0].lower(): (x[1] if len(x) >= 2 else None)
    for x in (
        y.split('==') for y in freeze()
    )
}

print('\nInstalled packages:')
pprint(INSTALLED_PKGS)


@pytest.mark.skipif(
    'uvloop' not in INSTALLED_PKGS,
    reason="skipping test for package not installed: 'uvloop'"
)
def test_has_uvloop():
    import asyncio
    import uvloop

    asyncio.set_event_loop_policy(uvloop.EventLoopPolicy())


def test_has_discord():
    import discord
    assert discord.__version__

    client = discord.Client(intents=discord.Intents.all())
    assert hasattr(client, 'run')

    from discord.ext import commands

    bot = commands.Bot('?', intents=discord.Intents.all())
    assert hasattr(bot, 'on_message')


def test_has_voice():
    from discord.voice_client import has_nacl
    from discord.opus import is_loaded, Encoder

    Encoder()  # Ensure opus gets loaded

    assert has_nacl
    assert is_loaded()


@pytest.mark.skipif(
    'pyyaml' not in INSTALLED_PKGS,
    reason="skipping test for package not installed: 'pyyaml'"
)
def test_has_pyyaml():
    from inspect import cleandoc
    from random import randint

    from yaml import safe_load, dump

    data = safe_load(cleandoc('''
    - 123
    - "quoted text"
    - unquoted text
    - sample: |
        some text right here
    '''))

    assert data[0] == 123
    assert data[1] == 'quoted text'
    assert data[2] == 'unquoted text'
    assert isinstance(data[3], dict)
    assert data[3]['sample'].strip() == 'some text right here'

    random_data = [randint(0, 1000) for x in range(200)]
    assert safe_load(dump(random_data)) == random_data


@pytest.mark.skipif(
    'ruamel.yaml' not in INSTALLED_PKGS,
    reason="skipping test for package not installed: 'ruamel.yaml'"
)
def test_has_ruamel():
    from inspect import cleandoc
    from random import randint
    from io import StringIO

    from ruamel.yaml import YAML

    yaml = YAML(typ='safe')
    data = yaml.load(cleandoc('''
    - 123
    - "quoted text"
    - unquoted text
    - sample: |
        some text right here
    '''))

    assert data[0] == 123
    assert data[1] == 'quoted text'
    assert data[2] == 'unquoted text'
    assert isinstance(data[3], dict)
    assert data[3]['sample'].strip() == 'some text right here'

    buff = StringIO()

    random_data = [randint(0, 1000) for x in range(200)]
    yaml.dump(random_data, buff)
    buff.seek(0)
    assert yaml.load(buff) == random_data


@pytest.mark.skipif(
    'fuzzywuzzy' not in INSTALLED_PKGS,
    reason="skipping test for package not installed: 'fuzzywuzzy'"
)
def test_has_fuzzywuzzy():
    from fuzzywuzzy import fuzz, process

    assert fuzz.ratio('this is a test', 'this is a test!') > 96
    guess, confidence = process.extractOne('apple', 'alpha beta gamma sigma'.split())
    assert guess == 'alpha'
    assert confidence < 50


@pytest.mark.skipif(
    'pycryptodome' not in INSTALLED_PKGS,
    reason="skipping test for package not installed: 'pycryptodome'"
)
@pytest.mark.parametrize(
    'hash_type',
    ['SHA256', 'SHA384', 'SHA512']
)
def test_has_pycryptodome_hash(hash_type: str):
    import hashlib

    from Crypto import Random

    hashlib_hash = getattr(hashlib, hash_type.lower())
    pycrypto_hash = importlib.import_module(f'Crypto.Hash.{hash_type}')

    rndfile = Random.new()

    test = rndfile.read(1024)
    factory = pycrypto_hash.new()
    factory.update(test)
    assert hashlib_hash(test).digest() == factory.digest()


@pytest.mark.skipif(
    'pycryptodome' not in INSTALLED_PKGS,
    reason="skipping test for package not installed: 'pycryptodome'"
)
@pytest.mark.parametrize(
    'cipher_type',
    ['AES', 'ARC2', 'Blowfish', 'CAST', 'DES3']
)
def test_has_pycryptodome_cipher(cipher_type):
    from Crypto import Random

    pycrypto_cipher = importlib.import_module(f'Crypto.Cipher.{cipher_type}')

    rndfile = Random.new()

    key = rndfile.read(pycrypto_cipher.key_size[-1])
    iv = rndfile.read(pycrypto_cipher.block_size)

    enc = pycrypto_cipher.new(key=key, mode=pycrypto_cipher.MODE_CBC, iv=iv)

    text = rndfile.read(1024)
    ciphertext = enc.encrypt(text)

    dec = pycrypto_cipher.new(key=key, mode=pycrypto_cipher.MODE_CBC, iv=iv)

    return_text = dec.decrypt(ciphertext)

    assert text != ciphertext
    assert text == return_text

@pytest.mark.skipif(
    'pillow' not in INSTALLED_PKGS,
    reason="skipping test for package not installed: 'pillow'"
)
def test_has_pillow():
    import colorsys
    import itertools
    import pathlib
    from PIL import Image, ImageChops

    data = bytes([int(x*255) for x in itertools.chain(*[colorsys.hsv_to_rgb(x / 255, 1, 1) for x in range(256)])])

    with Image.frombytes('RGB', (256, 1), data).resize((256, 100), Image.BICUBIC) as im:
        # write standard PNG file
        im.save('_test_pillow.png', 'png')
        assert pathlib.Path('_test_pillow.png').exists()

        # test quantization
        quantized = im.quantize()

        # write paletted BMP file
        quantized.save('_test_pillow.bmp', 'bmp')
        assert pathlib.Path('_test_pillow.bmp').exists()

        # write paletted GIF file
        quantized.save('_test_pillow.gif', 'gif')
        assert pathlib.Path('_test_pillow.gif').exists()

        # double quantization
        quantized2 = im.quantize(colors=16)

        # write paletted BMP file
        quantized2.save('_test_pillow_2.bmp', 'bmp')
        assert pathlib.Path('_test_pillow_2.bmp').exists()

        # write paletted GIF file
        quantized2.save('_test_pillow_2.gif', 'gif')
        assert pathlib.Path('_test_pillow_2.gif').exists()

        r, g, b = im.split()
        a = ImageChops.add(r, b, scale=2)
        im2 = Image.merge('RGBA', (r, g, b, a))

        # write transparent PNG file
        im2.save('_test_pillow_2.png', 'png')
        assert pathlib.Path('_test_pillow_2.png').exists()


@pytest.mark.skipif(
    'lxml' not in INSTALLED_PKGS,
    reason="skipping test for package not installed: 'lxml'"
)
def test_lxml():
    from lxml import etree

    root = etree.Element('root')
    etree.SubElement(root, 'a')
    etree.SubElement(root, 'b')
    c = etree.SubElement(root, 'c')
    d = etree.SubElement(c, 'd')
    e = etree.SubElement(d, 'e')
    e.text = 'test'
    tree = etree.ElementTree(root)

    assert etree.tostring(tree) == b'<root><a/><b/><c><d><e>test</e></d></c></root>'


@pytest.mark.skipif(
    'beautifulsoup4' not in INSTALLED_PKGS,
    reason="skipping test for package not installed: 'beautifulsoup4'"
)
def test_bs4():
    from bs4 import BeautifulSoup
    soup = BeautifulSoup('<html><head><title>test title</title></head>\n<body><b>test</b> text</body></html>', 'html.parser')
    assert soup.title.string == 'test title'
    assert soup.get_text() == 'test title\ntest text'


@pytest.mark.parametrize(
    'db',
    ['aiomysql', 'redis', 'asyncpg']
)
def test_db_shallow(db):
    db_module = pytest.importorskip(db)
    assert db_module.__version__
    assert isinstance(db_module.__version__, str)


@pytest.mark.skipif(
    'wand' not in INSTALLED_PKGS,
    reason="skipping test for package not installed: 'wand'"
)
def test_wand():
    import pathlib

    from wand.color import Color
    from wand.drawing import Drawing
    from wand.image import Image

    with Image(width=500, height=500) as outer:
        background_color = Color('#f00')
        with Image(width=250, height=250, background=background_color) as red_inner:
            outer.composite(red_inner, left=125, top=125)
        with outer.convert('png') as converted:
            converted.save(filename='_test_wand.png')

    assert pathlib.Path('_test_wand.png').exists()

    with Drawing() as draw:
        draw.stroke_color = Color('black')
        draw.stroke_width = 2
        draw.fill_color = Color('white')
        draw.arc(
            (25, 25),
            (75, 75),
            (135, -45)
        )

        with Image(width=100, height=100, background=Color('lightblue')) as im:
            draw.draw(im)
            with im.convert('png') as converted:
                converted.save(filename='_test_wand_2.png')

    assert pathlib.Path('_test_wand_2.png').exists()


@pytest.mark.skipif(
    'numpy' not in INSTALLED_PKGS,
    reason="skipping test for package not installed: 'numpy'"
)
def test_has_numpy():
    import numpy as np

    a = np.arange(15).reshape(3, 5)
    b = a.T.reshape(15)
    c = (a.T @ a).reshape(25)
    assert all(b == [0, 5, 10, 1, 6, 11, 2, 7, 12, 3, 8, 13, 4, 9, 14])
    assert all(c == [125, 140, 155, 170, 185,
                     140, 158, 176, 194, 212,
                     155, 176, 197, 218, 239,
                     170, 194, 218, 242, 266,
                     185, 212, 239, 266, 293])


@pytest.mark.skipif(
    'scipy' not in INSTALLED_PKGS,
    reason="skipping test for package not installed: 'scipy'"
)
def test_has_scipy():
    from scipy import integrate

    def f(x):
        # dy/dx = 4x^3 + 6x^2
        # so
        # y = x^4 + 2x^3
        return (4 * (x ** 3)) + (6 * (x ** 2))

    # where x = 1, y = 1^4 + 2*(1^4) = 1 + 2 = 3
    # where x = 2, y = 2^4 + 2*(2^4) = 16 + 16 = 32
    # so integrating between 1 and 2 for dy/dx gives us 3 - 32 = 29
    answer, error = integrate.quad(f, 1, 2)
    # check within bounds
    assert answer + error >= 29
    assert answer - error <= 29


@pytest.mark.skipif(
    'matplotlib' not in INSTALLED_PKGS,
    reason="skipping test for package not installed: 'matplotlib'"
)
def test_has_matplotlib():
    import pathlib
    from io import BytesIO

    import matplotlib
    matplotlib.use('Agg')

    import numpy as np
    import matplotlib.pyplot as plt
    import matplotlib.tri as mtri
    from cycler import cycler
    from matplotlib import cm
    from mpl_toolkits.mplot3d.axes3d import get_test_data

    X = np.arange(-5, 5, 0.25)
    Y = np.arange(-5, 5, 0.25)
    X, Y = np.meshgrid(X, Y)
    R = np.sqrt(X**2 + Y**2)
    Z = np.sin(R)

    fig = plt.figure(figsize=(19.2, 14.4))
    ax = fig.add_subplot(3, 3, 1, projection='3d')
    ax.plot_surface(X, Y, Z, rstride=1, cstride=1, cmap=cm.viridis)

    ax.set_title('matplotlib')

    ax2 = fig.add_subplot(3, 3, 2, projection='3d')
    X, Y, Z = get_test_data(0.05)
    ax2.plot_wireframe(X, Y, Z, rstride=5, cstride=5, linestyles='dashdot')

    ax2.set_title('3d')

    u = np.linspace(0, 2.0 * np.pi, endpoint=True, num=50)
    v = np.linspace(-0.5, 0.5, endpoint=True, num=10)
    u, v = np.meshgrid(u, v)
    u, v = u.flatten(), v.flatten()

    x = (1 + 0.5 * v * np.cos(u / 2.0)) * np.cos(u)
    y = (1 + 0.5 * v * np.cos(u / 2.0)) * np.sin(u)
    z = 0.5 * v * np.sin(u / 2.0)

    tri = mtri.Triangulation(u, v)

    ax3 = fig.add_subplot(3, 3, 3, projection='3d')
    ax3.plot_trisurf(x, y, z, triangles=tri.triangles, cmap=cm.jet)

    ax3.set_title('plot')

    radii = np.linspace(0.125, 1.0, 8)
    angles = np.linspace(0, 2*np.pi, 36, endpoint=False)

    angles = np.repeat(angles[..., np.newaxis], 8, axis=1)

    x = np.append(0, (radii*np.cos(angles)).flatten())
    y = np.append(0, (radii*np.sin(angles)).flatten())

    z = np.sin(-x*y)

    ax4 = fig.add_subplot(3, 3, 4, projection='3d')
    ax4.plot_trisurf(x, y, z, linewidth=0.2, cmap=cm.Spectral)

    ax4.set_title('test')

    X, Y, Z = get_test_data(0.05)
    ax5 = fig.add_subplot(3, 3, 5, projection='3d')
    ax5.contour(X, Y, Z, extend3d=True, cmap=cm.coolwarm)

    ax5.set_title('for')

    ax6 = fig.add_subplot(3, 3, 6, projection='3d')

    ax6.plot_surface(X, Y, Z, rstride=8, cstride=8, alpha=0.3)
    ax6.contour(X, Y, Z, zdir='z', offset=-100, cmap=cm.coolwarm)
    ax6.contour(X, Y, Z, zdir='x', offset=-40, cmap=cm.coolwarm)
    ax6.contour(X, Y, Z, zdir='y', offset=40, cmap=cm.coolwarm)

    ax6.set_xlim(-40, 40)
    ax6.set_ylim(-40, 40)
    ax6.set_zlim(-100, 100)

    ax6.set_title('docker')

    theta = np.linspace(0.0, 2 * np.pi, 20, endpoint=False)
    radii = 10 * np.random.rand(20)
    width = np.pi / 4 * np.random.rand(20)

    ax7 = fig.add_subplot(3, 3, 7, projection='polar')
    bars = ax7.bar(theta, radii, width=width, bottom=0.0)

    for r, bar in zip(radii, bars):
        bar.set_facecolor(cm.viridis(r / 10.))
        bar.set_alpha(0.5)

    ax7.set_title('also this')

    x = np.linspace(0, 2 * np.pi)
    offsets = np.linspace(0, 2*np.pi, 4, endpoint=False)

    yy = np.transpose([np.sin(x + phi) for phi in offsets])

    ax8 = fig.add_subplot(3, 2, 6)
    ax8.set_prop_cycle(cycler('color', ['r', 'g', 'b', 'y']) +
                    cycler('linestyle', ['-', '--', ':', '-.']))

    ax8.plot(yy)

    ax8.set_title('and one of these too')

    # check it writes to buffer properly first
    out_buffer = BytesIO()
    plt.savefig(out_buffer, dpi=160, format='png', bbox_inches='tight')
    out_buffer.seek(0)

    assert out_buffer.read(4) == b'\x89PNG'

    # write to file for good measure
    with open('_test_plot_image.png', 'wb') as op:
        op.write(b'\x89PNG' + out_buffer.read())

    assert pathlib.Path('_test_plot_image.png').exists()
{{ '' }}
