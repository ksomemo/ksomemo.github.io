* zlibによる文字列の圧縮
* base64で文字列として扱えるように

```py3
import zlib
import base64
import sys

def main():
    mode = sys.argv[1] if len(sys.argv) > 1 else ''
    if mode == 'c':
        with open("test.txt") as f, open("compress.txt", "wb") as c:
            text = f.read()
            c.write(base64.b64encode(zlib.compress(bytes(text, 'utf8'))))
    elif mode == 'd':
        with open("comp_decomp.txt", "w") as out, open("compress.txt", "r") as c:
            text = zlib.decompress(base64.b64decode(c.read()))
            out.write(text.decode('utf8'))

if __name__ == "__main__":
    main()
```

## binascii

```py3
import binascii

def main():
    with open("test.zip", "rb") as z, open("out.txt", "wb") as o:
        contents = binascii.b2a_base64(z.read())
        o.write(contents)

    with open("out.txt") as src, open("decode.zip", "wb") as d:
        contents = binascii.a2b_base64(src.read())
        d.write(contents)

if __name__ == "__main__":
    main()
```
