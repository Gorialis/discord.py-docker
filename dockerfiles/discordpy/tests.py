# -*- coding: utf8 -*-

"""
discord.py-docker test script

this script is used to determine if a container has built correctly or not
"""

import sys
from pip._internal.operations.freeze import freeze

installed_pkgs = [x.split('==')[0].lower() for x in freeze()]

if 'uvloop' in installed_pkgs:
    def test_has_uvloop():
        import asyncio
        import uvloop

        asyncio.set_event_loop_policy(uvloop.EventLoopPolicy())

def test_has_discord():
    import discord
    assert discord.__version__

    client = discord.Client()
    client.loop.run_until_complete(client.close())

    from discord.ext import commands
    bot = commands.Bot('?')
    assert hasattr(bot, 'on_message')
    bot.loop.run_until_complete(bot.close())

def test_has_voice():
    from discord.voice_client import has_nacl
    from discord.opus import is_loaded

    assert has_nacl
    assert is_loaded()

if 'numpy' in installed_pkgs:
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

if 'scipy' in installed_pkgs:
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
        assert (answer + error) >= 29 and (answer - error) <= 29

if 'pyyaml' in installed_pkgs:
    def test_has_pyyaml():
        from random import randint

        from yaml import safe_load, dump

        data = safe_load('- 123\n- "quoted text"\n- unquoted text\n- sample: |\n    some text right here')

        assert data[0] == 123
        assert data[1] == 'quoted text'
        assert data[2] == 'unquoted text'
        assert isinstance(data[3], dict)
        assert data[3]['sample'].strip() == 'some text right here'

        random_data = [randint(0, 1000) for x in range(200)]
        assert safe_load(dump(random_data)) == random_data

if 'ruamel.yaml' in installed_pkgs:
    def test_has_ruamel():
        from random import randint
        from io import StringIO

        from ruamel.yaml import YAML

        yaml = YAML(typ='safe')
        data = yaml.load('- 123\n- "quoted text"\n- unquoted text\n- sample: |\n    some text right here')

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

if 'fuzzywuzzy' in installed_pkgs:
    def test_has_fuzzywuzzy():
        from fuzzywuzzy import fuzz, process

        assert fuzz.ratio('this is a test', 'this is a test!') > 96
        guess, confidence = process.extractOne('apple', 'alpha beta gamma sigma'.split())
        assert guess == 'alpha'
        assert confidence < 50

if 'pycryptodome' in installed_pkgs:
    def test_has_pycryptodome():
        from Crypto import Random
        rndfile = Random.new()

        from Crypto.Hash import SHA256
        from hashlib import sha256

        sha256_test = rndfile.read(1024)
        sha256_factory = SHA256.new()
        sha256_factory.update(sha256_test)
        assert sha256(sha256_test).digest() == sha256_factory.digest()

        from Crypto.Hash import SHA384
        from hashlib import sha384

        sha384_test = rndfile.read(1024)
        sha384_factory = SHA384.new()
        sha384_factory.update(sha384_test)
        assert sha384(sha384_test).digest() == sha384_factory.digest()

        from Crypto.Hash import SHA512
        from hashlib import sha512

        sha512_test = rndfile.read(1024)
        sha512_factory = SHA512.new()
        sha512_factory.update(sha512_test)
        assert sha512(sha512_test).digest() == sha512_factory.digest()

        from Crypto.Cipher import AES

        aes_key = rndfile.read(AES.key_size[-1])
        aes_iv = rndfile.read(AES.block_size)

        aes_enc = AES.new(key=aes_key, mode=AES.MODE_CBC, iv=aes_iv)

        aes_text = rndfile.read(1024)
        aes_ciphertext = aes_enc.encrypt(aes_text)

        aes_dec = AES.new(key=aes_key, mode=AES.MODE_CBC, iv=aes_iv)

        aes_return = aes_dec.decrypt(aes_ciphertext)

        assert aes_text != aes_ciphertext
        assert aes_text == aes_return

        from Crypto.Cipher import ARC2

        arc2_key = rndfile.read(ARC2.key_size[-1])
        arc2_iv = rndfile.read(ARC2.block_size)

        arc2_enc = ARC2.new(key=arc2_key, mode=ARC2.MODE_CBC, iv=arc2_iv)

        arc2_text = rndfile.read(1024)
        arc2_ciphertext = arc2_enc.encrypt(arc2_text)

        arc2_dec = ARC2.new(key=arc2_key, mode=ARC2.MODE_CBC, iv=arc2_iv)

        arc2_return = arc2_dec.decrypt(arc2_ciphertext)

        assert arc2_text != arc2_ciphertext
        assert arc2_text == arc2_return

        from Crypto.Cipher import Blowfish

        blowfish_key = rndfile.read(Blowfish.key_size[-1])
        blowfish_iv = rndfile.read(Blowfish.block_size)

        blowfish_enc = Blowfish.new(key=blowfish_key, mode=Blowfish.MODE_CBC, iv=blowfish_iv)

        blowfish_text = rndfile.read(1024)
        blowfish_ciphertext = blowfish_enc.encrypt(blowfish_text)

        blowfish_dec = Blowfish.new(key=blowfish_key, mode=Blowfish.MODE_CBC, iv=blowfish_iv)

        blowfish_return = blowfish_dec.decrypt(blowfish_ciphertext)

        assert blowfish_text != blowfish_ciphertext
        assert blowfish_text == blowfish_return

        from Crypto.Cipher import CAST

        cast_key = rndfile.read(CAST.key_size[-1])
        cast_iv = rndfile.read(CAST.block_size)

        cast_enc = CAST.new(key=cast_key, mode=CAST.MODE_CBC, iv=cast_iv)

        cast_text = rndfile.read(1024)
        cast_ciphertext = cast_enc.encrypt(cast_text)

        cast_dec = CAST.new(key=cast_key, mode=CAST.MODE_CBC, iv=cast_iv)

        cast_return = cast_dec.decrypt(cast_ciphertext)

        assert cast_text != cast_ciphertext
        assert cast_text == cast_return

        from Crypto.Cipher import DES3

        des3_key = rndfile.read(DES3.key_size[-1])
        des3_iv = rndfile.read(DES3.block_size)

        des3_enc = DES3.new(key=des3_key, mode=DES3.MODE_CBC, iv=des3_iv)

        des3_text = rndfile.read(1024)
        des3_ciphertext = des3_enc.encrypt(des3_text)

        des3_dec = DES3.new(key=des3_key, mode=DES3.MODE_CBC, iv=des3_iv)

        des3_return = des3_dec.decrypt(des3_ciphertext)

        assert des3_text != des3_ciphertext
        assert des3_text == des3_return

if 'matplotlib' in installed_pkgs:
    def test_has_matplotlib():
        import matplotlib
        matplotlib.use('Agg')
        import numpy as np
        import matplotlib.pyplot as plt
        import matplotlib.tri as mtri
        from cycler import cycler
        from matplotlib import cm
        from mpl_toolkits.mplot3d.axes3d import get_test_data
        from io import BytesIO

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

if 'pillow' in installed_pkgs:
    def test_has_pillow():
        import colorsys
        import itertools
        from PIL import Image, ImageChops

        data = bytes([int(x*255) for x in itertools.chain(*[colorsys.hsv_to_rgb(x / 255, 1, 1) for x in range(256)])])

        with Image.frombytes('RGB', (256, 1), data).resize((256, 100), Image.ANTIALIAS) as im:
            # write standard PNG file
            im.save('_test_pillow.png', 'png')
            # test quantization
            quantized = im.quantize()
            # write paletted BMP file
            quantized.save('_test_pillow.bmp', 'bmp')
            # write paletted GIF file
            quantized.save('_test_pillow.gif', 'gif')
            # double quantization
            quantized2 = im.quantize(colors=16)
            # write paletted BMP file
            quantized2.save('_test_pillow_2.bmp', 'bmp')
            # write paletted GIF file
            quantized2.save('_test_pillow_2.gif', 'gif')

            r, g, b = im.split()
            a = ImageChops.add(r, b, scale=2)
            im2 = Image.merge('RGBA', (r, g, b, a))
            # write transparent PNG file
            im2.save('_test_pillow_2.png', 'png')

if 'lxml' in installed_pkgs:
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

if 'beautifulsoup4' in installed_pkgs:
    def test_bs4():
        from bs4 import BeautifulSoup
        soup = BeautifulSoup('<html><head><title>test title</title></head>\n<body><b>test</b> text</body></html>', 'html.parser')
        assert soup.title.string == 'test title'
        assert soup.get_text() == 'test title\ntest text'

if 'wand' in installed_pkgs:
    def test_wand():
        import wand

        from wand.color import Color
        from wand.image import Image

        with Image(width=500, height=500) as outer:
            background_color = Color('#f00')
            with Image(width=250, height=250, background=background_color) as red_inner:
                outer.composite(red_inner, left=125, top=125)
            with outer.convert('png') as converted:
                converted.save(filename='_test_wand.png')

if 'aiomysql' in installed_pkgs:
    def test_db_aiomysql_shallow():
        import aiomysql
        assert aiomysql.__version__

if 'aioredis' in installed_pkgs:
    def test_db_aioredis_shallow():
        import aioredis
        assert aioredis.__version__

if 'asyncpg' in installed_pkgs:
    def test_db_asyncpg_shallow():
        import asyncpg
        assert asyncpg.__version__

