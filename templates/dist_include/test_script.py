# -*- coding: utf8 -*-

"""
discord.py-docker test script

this script is used to determine if a container has built correctly or not
"""

import sys

if sys.platform != 'win32':
    def test_has_uvloop():
        import asyncio
        import uvloop

        asyncio.set_event_loop_policy(uvloop.EventLoopPolicy())

def test_has_discord():
    import discord
    client = discord.Client()
    client.loop.run_until_complete(client.close())

def test_has_voice():
    from discord.voice_client import has_nacl
    from discord.opus import is_loaded

    assert has_nacl
    assert is_loaded()

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

"""
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
"""

def test_has_pyyaml():
    from yaml import safe_load

    data = safe_load('- 123\n- "quoted text"\n- unquoted text\n- sample: |\n    some text right here')

    assert data[0] == 123
    assert data[1] == 'quoted text'
    assert data[2] == 'unquoted text'
    assert isinstance(data[3], dict)
    assert data[3]['sample'].strip() == 'some text right here'

def test_has_fuzzywuzzy():
    from fuzzywuzzy import fuzz, process

    assert fuzz.ratio('this is a test', 'this is a test!') > 96
    guess, confidence = process.extractOne('apple', 'alpha beta gamma sigma'.split())
    assert guess == 'alpha'
    assert confidence < 50

def test_has_matplotlib():
    import matplotlib
    matplotlib.use('Agg')
    import numpy as np
    import matplotlib.pyplot as plt
    from matplotlib import cm
    from mpl_toolkits.mplot3d import Axes3D
    from io import BytesIO

    X = np.arange(-5, 5, 0.25)
    Y = np.arange(-5, 5, 0.25)
    X, Y = np.meshgrid(X, Y)
    R = np.sqrt(X**2 + Y**2)
    Z = np.sin(R)

    fig = plt.figure()
    ax = Axes3D(fig)
    ax.plot_surface(X, Y, Z, rstride=1, cstride=1, cmap=cm.viridis)

    ax.set_title('matplotlib plot test')

    # check it writes to buffer properly first
    out_buffer = BytesIO()
    plt.savefig(out_buffer, dpi=80, format='png', bbox_inches='tight')
    out_buffer.seek(0)

    # write to file for good measure
    with open('_test_plot_image.png', 'wb') as op:
        op.write(out_buffer.read())

def test_has_aiofiles():
    import asyncio
    import aiofiles

    async def run_test():
        async with aiofiles.open('_test_read_write.txt', 'w', encoding='utf8') as f:
            await f.write('this is test sample text for aiofiles')

        async with aiofiles.open('_test_read_write.txt', 'r', encoding='utf8') as f:
            text = await f.read()
            assert text == 'this is test sample text for aiofiles'

    asyncio.get_event_loop().run_until_complete(run_test())

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

def test_lxml():
    from lxml import etree

    root = etree.Element('root')
    a = etree.SubElement(root, 'a')
    b = etree.SubElement(root, 'b')
    c = etree.SubElement(root, 'c')
    d = etree.SubElement(c, 'd')
    e = etree.SubElement(d, 'e')
    e.text = 'test'
    tree = etree.ElementTree(root)
    
    assert etree.tostring(tree) == b'<root><a/><b/><c><d><e>test</e></d></c></root>'

def test_bs4():
    from bs4 import BeautifulSoup
    soup = BeautifulSoup('<html><head><title>test title</title></head>\n<body><b>test</b> text</body></html>', 'html.parser')
    assert soup.title.string == 'test title'
    assert soup.get_text() == 'test title\ntest text'

def test_wand():
    from wand.color import Color
    from wand.image import Image

    with Image(width=500, height=500) as outer:
        with Image(width=250, height=250, background=Color('#f00')) as red_inner:
            outer.composite(red_inner, left=125, top=125)
        with outer.convert('png') as converted:
            converted.save(filename='_test_wand.png')

def test_db_shallow():
    # shallow test, just ensures they import ok
    import aiomysql
    import aioredis
    import asyncpg
    assert aiomysql.__version__
    assert aioredis.__version__
    assert asyncpg.__version__
