"""One-off generator for the app launcher icon (đợt 12, CLAUDE.md).
Not part of the app build — run manually (`python3 tool/generate_icon.py`
from `mobile/`) to regenerate assets/icon/app_icon*.png if the design ever
changes, then re-run `dart run flutter_launcher_icons`. Uses the palette
from `lib/theme/colors.dart` — keep these in sync if that file changes.
"""
import os
from PIL import Image, ImageDraw, ImageFilter

_MOBILE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

BG_DARK = (10, 20, 29, 255)      # 0xFF0A141D
BG_MID = (22, 40, 58, 255)       # 0xFF16283A
ACCENT = (232, 163, 61, 255)     # 0xFFE8A33D
ACCENT_DARK = (201, 124, 46, 255)  # 0xFFC97C2E

SS = 4  # supersampling factor for clean anti-aliasing
SIZE = 1024 * SS


def diagonal_gradient(size, c1, c2):
    img = Image.new("RGBA", (size, size))
    px = img.load()
    for y in range(size):
        for x in range(size):
            t = (x + y) / (2 * size)
            r = int(c1[0] + (c2[0] - c1[0]) * t)
            g = int(c1[1] + (c2[1] - c1[1]) * t)
            b = int(c1[2] + (c2[2] - c1[2]) * t)
            px[x, y] = (r, g, b, 255)
    return img


def rounded_square_mask(size, radius_ratio=0.22):
    mask = Image.new("L", (size, size), 0)
    d = ImageDraw.Draw(mask)
    d.rounded_rectangle([0, 0, size - 1, size - 1], radius=int(size * radius_ratio), fill=255)
    return mask


def draw_pin(draw, cx, cy, head_r, tail_len, fill):
    """Classic map-marker teardrop: a circle head with a triangular tail
    tangent to it, pointing straight down."""
    draw.ellipse([cx - head_r, cy - head_r, cx + head_r, cy + head_r], fill=fill)
    tail_half_w = head_r * 0.62
    tail_top_y = cy + head_r * 0.42
    tip = (cx, cy + head_r + tail_len)
    draw.polygon([(cx - tail_half_w, tail_top_y), (cx + tail_half_w, tail_top_y), tip], fill=fill)


def make_legacy_icon(out_path):
    bg = diagonal_gradient(SIZE, BG_DARK, BG_MID)
    mask = rounded_square_mask(SIZE)
    canvas = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    canvas.paste(bg, (0, 0), mask)

    draw = ImageDraw.Draw(canvas)
    cx, cy = SIZE // 2, int(SIZE * 0.44)
    head_r = int(SIZE * 0.20)
    tail_len = int(SIZE * 0.24)

    # soft shadow under the pin for depth
    shadow = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    sd = ImageDraw.Draw(shadow)
    draw_pin(sd, cx, cy + int(SIZE * 0.018), head_r, tail_len, (0, 0, 0, 90))
    shadow = shadow.filter(ImageFilter.GaussianBlur(SIZE * 0.012))
    canvas.alpha_composite(shadow)

    draw_pin(draw, cx, cy, head_r, tail_len, ACCENT)
    # inner "hole" near the top of the head, in the bg-mid tone, for the
    # classic pin look
    hole_r = int(head_r * 0.40)
    draw.ellipse([cx - hole_r, cy - hole_r, cx + hole_r, cy + hole_r], fill=BG_MID)
    # thin accent-dark ring around the hole for a bit of polish
    ring_r = int(hole_r * 1.12)
    draw.ellipse([cx - ring_r, cy - ring_r, cx + ring_r, cy + ring_r], outline=ACCENT_DARK, width=max(2, SIZE // 256))
    draw.ellipse([cx - hole_r, cy - hole_r, cx + hole_r, cy + hole_r], fill=BG_MID)

    canvas = canvas.resize((1024, 1024), Image.LANCZOS)
    canvas.save(out_path)


def make_foreground_icon(out_path):
    # Adaptive icon foreground: transparent bg, pin kept inside the ~66%
    # safe zone so it isn't clipped by circle/squircle/rounded-square masks.
    canvas = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    draw = ImageDraw.Draw(canvas)
    cx, cy = SIZE // 2, int(SIZE * 0.46)
    head_r = int(SIZE * 0.145)
    tail_len = int(SIZE * 0.17)

    shadow = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    sd = ImageDraw.Draw(shadow)
    draw_pin(sd, cx, cy + int(SIZE * 0.014), head_r, tail_len, (0, 0, 0, 80))
    shadow = shadow.filter(ImageFilter.GaussianBlur(SIZE * 0.01))
    canvas.alpha_composite(shadow)

    draw_pin(draw, cx, cy, head_r, tail_len, ACCENT)
    hole_r = int(head_r * 0.40)
    draw.ellipse([cx - hole_r, cy - hole_r, cx + hole_r, cy + hole_r], fill=(0, 0, 0, 0))
    # re-punch the hole as true transparency (so it reads correctly on any
    # background the OS composites behind the adaptive foreground)
    mask = Image.new("L", (SIZE, SIZE), 255)
    md = ImageDraw.Draw(mask)
    md.ellipse([cx - hole_r, cy - hole_r, cx + hole_r, cy + hole_r], fill=0)
    canvas.putalpha(Image.composite(canvas.split()[3], Image.new("L", (SIZE, SIZE), 0), mask))

    canvas = canvas.resize((1024, 1024), Image.LANCZOS)
    canvas.save(out_path)


if __name__ == "__main__":
    icon_dir = os.path.join(_MOBILE_DIR, "assets", "icon")
    make_legacy_icon(os.path.join(icon_dir, "app_icon.png"))
    make_foreground_icon(os.path.join(icon_dir, "app_icon_foreground.png"))
    print("done")
