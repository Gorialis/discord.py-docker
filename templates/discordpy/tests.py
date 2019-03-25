# -*- coding: utf8 -*-

"""
discord.py-docker test script

this script is used to determine if a container has built correctly or not
"""

import unittest
from pprint import pprint

from pip._internal.operations.freeze import freeze

INSTALLED_PKGS = {
    x[0].lower(): x[1]
    for x in (
        y.split('==') for y in freeze()
    )
}

print('\nInstalled packages:')
pprint(INSTALLED_PKGS)


class PackageTests(unittest.TestCase):
    """
    Tests installed packages function properly
    """

    if 'uvloop' in INSTALLED_PKGS:
        def test_has_uvloop(self):
            import asyncio
            import uvloop

            asyncio.set_event_loop_policy(uvloop.EventLoopPolicy())


    def test_has_discord(self):
        import discord
        self.assertTrue(discord.__version__)

        client = discord.Client()
        self.assertTrue(hasattr(client, 'run'))

        from discord.ext import commands

        bot = commands.Bot('?')
        self.assertTrue(hasattr(bot, 'on_message'))


    def test_has_voice(self):
        from discord.voice_client import has_nacl
        from discord.opus import is_loaded

        self.assertTrue(has_nacl)
        self.assertTrue(is_loaded())


    if 'pyyaml' in INSTALLED_PKGS:
        def test_has_pyyaml(self):
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

            self.assertEqual(data[0], 123)
            self.assertEqual(data[1], 'quoted text')
            self.assertEqual(data[2], 'unquoted text')
            self.assertIsInstance(data[3], dict)
            self.assertEqual(data[3]['sample'].strip(), 'some text right here')

            random_data = [randint(0, 1000) for x in range(200)]
            self.assertEqual(safe_load(dump(random_data)), random_data)


    if 'ruamel.yaml' in INSTALLED_PKGS:
        def test_has_ruamel(self):
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

            self.assertEqual(data[0], 123)
            self.assertEqual(data[1], 'quoted text')
            self.assertEqual(data[2], 'unquoted text')
            self.assertIsInstance(data[3], dict)
            self.assertEqual(data[3]['sample'].strip(), 'some text right here')

            buff = StringIO()

            random_data = [randint(0, 1000) for x in range(200)]
            yaml.dump(random_data, buff)
            buff.seek(0)
            self.assertEqual(yaml.load(buff), random_data)


    if 'fuzzywuzzy' in INSTALLED_PKGS:
        def test_has_fuzzywuzzy(self):
            from fuzzywuzzy import fuzz, process

            self.assertGreater(fuzz.ratio('this is a test', 'this is a test!'), 96)
            guess, confidence = process.extractOne('apple', 'alpha beta gamma sigma'.split())
            self.assertEqual(guess, 'alpha')
            self.assertLess(confidence, 50)


    if 'pycryptodome' in INSTALLED_PKGS:
        {%- for hash_type in ['SHA256', 'SHA384', 'SHA512'] %}
        def test_has_pycryptodome_hash_{{ hash_type|lower }}(self):
            from hashlib import {{ hash_type|lower }}

            from Crypto import Random
            from Crypto.Hash import {{ hash_type }}

            rndfile = Random.new()

            {{ hash_type|lower }}_test = rndfile.read(1024)
            {{ hash_type|lower }}_factory = {{ hash_type }}.new()
            {{ hash_type|lower }}_factory.update({{ hash_type|lower }}_test)
            self.assertEqual({{ hash_type|lower }}({{ hash_type|lower }}_test).digest(), {{ hash_type|lower }}_factory.digest())
        {% endfor %}

        {%- for cipher_type in ['AES', 'ARC2', 'Blowfish', 'CAST', 'DES3'] %}
        def test_has_pycryptodome_cipher_{{ cipher_type|lower }}(self):
            from Crypto import Random
            from Crypto.Cipher import {{ cipher_type }}

            rndfile = Random.new()

            {{ cipher_type|lower }}_key = rndfile.read({{ cipher_type }}.key_size[-1])
            {{ cipher_type|lower }}_iv = rndfile.read({{ cipher_type }}.block_size)

            {{ cipher_type|lower }}_enc = {{ cipher_type }}.new(key={{ cipher_type|lower }}_key, mode={{ cipher_type }}.MODE_CBC, iv={{ cipher_type|lower }}_iv)

            {{ cipher_type|lower }}_text = rndfile.read(1024)
            {{ cipher_type|lower }}_ciphertext = {{ cipher_type|lower }}_enc.encrypt({{ cipher_type|lower }}_text)

            {{ cipher_type|lower }}_dec = {{ cipher_type }}.new(key={{ cipher_type|lower }}_key, mode={{ cipher_type }}.MODE_CBC, iv={{ cipher_type|lower }}_iv)

            {{ cipher_type|lower }}_return = {{ cipher_type|lower }}_dec.decrypt({{ cipher_type|lower }}_ciphertext)

            self.assertNotEqual({{ cipher_type|lower }}_text, {{ cipher_type|lower }}_ciphertext)
            self.assertEqual({{ cipher_type|lower }}_text, {{ cipher_type|lower }}_return)
        {% endfor %}

    if 'pillow' in INSTALLED_PKGS:
        def test_has_pillow(self):
            import colorsys
            import itertools
            import pathlib
            from PIL import Image, ImageChops

            data = bytes([int(x*255) for x in itertools.chain(*[colorsys.hsv_to_rgb(x / 255, 1, 1) for x in range(256)])])

            with Image.frombytes('RGB', (256, 1), data).resize((256, 100), Image.ANTIALIAS) as im:
                # write standard PNG file
                im.save('_test_pillow.png', 'png')
                self.assertTrue(pathlib.Path('_test_pillow.png').exists())

                # test quantization
                quantized = im.quantize()

                # write paletted BMP file
                quantized.save('_test_pillow.bmp', 'bmp')
                self.assertTrue(pathlib.Path('_test_pillow.bmp').exists())

                # write paletted GIF file
                quantized.save('_test_pillow.gif', 'gif')
                self.assertTrue(pathlib.Path('_test_pillow.gif').exists())

                # double quantization
                quantized2 = im.quantize(colors=16)

                # write paletted BMP file
                quantized2.save('_test_pillow_2.bmp', 'bmp')
                self.assertTrue(pathlib.Path('_test_pillow_2.bmp').exists())

                # write paletted GIF file
                quantized2.save('_test_pillow_2.gif', 'gif')
                self.assertTrue(pathlib.Path('_test_pillow_2.gif').exists())

                r, g, b = im.split()
                a = ImageChops.add(r, b, scale=2)
                im2 = Image.merge('RGBA', (r, g, b, a))

                # write transparent PNG file
                im2.save('_test_pillow_2.png', 'png')
                self.assertTrue(pathlib.Path('_test_pillow_2.png').exists())


    if 'lxml' in INSTALLED_PKGS:
        def test_lxml(self):
            from lxml import etree

            root = etree.Element('root')
            etree.SubElement(root, 'a')
            etree.SubElement(root, 'b')
            c = etree.SubElement(root, 'c')
            d = etree.SubElement(c, 'd')
            e = etree.SubElement(d, 'e')
            e.text = 'test'
            tree = etree.ElementTree(root)

            self.assertEqual(etree.tostring(tree), b'<root><a/><b/><c><d><e>test</e></d></c></root>')


    if 'beautifulsoup4' in INSTALLED_PKGS:
        def test_bs4(self):
            from bs4 import BeautifulSoup
            soup = BeautifulSoup('<html><head><title>test title</title></head>\n<body><b>test</b> text</body></html>', 'html.parser')
            self.assertEqual(soup.title.string, 'test title')
            self.assertEqual(soup.get_text(), 'test title\ntest text')


    {%- for db in ['aiomysql', 'aioredis', 'asyncpg'] %}


    if '{{ db }}' in INSTALLED_PKGS:
        def test_db_{{ db }}_shallow(self):
            import {{ db }}
            self.assertTrue({{ db }}.__version__)
            self.assertIsInstance({{ db }}.__version__, str)

    {%- endfor %}


    if 'wand' in INSTALLED_PKGS:
        def test_wand(self):
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

            self.assertTrue(pathlib.Path('_test_wand.png').exists())

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

            self.assertTrue(pathlib.Path('_test_wand_2.png').exists())


    if 'numpy' in INSTALLED_PKGS:
        def test_has_numpy(self):
            import numpy as np

            a = np.arange(15).reshape(3, 5)
            b = a.T.reshape(15)
            c = (a.T @ a).reshape(25)
            self.assertTrue(all(b == [0, 5, 10, 1, 6, 11, 2, 7, 12, 3, 8, 13, 4, 9, 14]))
            self.assertTrue(all(c == [125, 140, 155, 170, 185,
                                      140, 158, 176, 194, 212,
                                      155, 176, 197, 218, 239,
                                      170, 194, 218, 242, 266,
                                      185, 212, 239, 266, 293]))


    if 'scipy' in INSTALLED_PKGS:
        def test_has_scipy(self):
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
            self.assertGreaterEqual(answer + error, 29)
            self.assertLessEqual(answer - error, 29)


    if 'matplotlib' in INSTALLED_PKGS:
        def test_has_matplotlib(self):
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

            self.assertEqual(out_buffer.read(4), b'\x89PNG')

            # write to file for good measure
            with open('_test_plot_image.png', 'wb') as op:
                op.write(b'\x89PNG' + out_buffer.read())

            self.assertTrue(pathlib.Path('_test_plot_image.png').exists())
{{ '' }}
