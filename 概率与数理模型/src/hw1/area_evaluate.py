import argparse
import math
from pathlib import Path

from PIL import Image

BLUE = (91, 155, 213)
YELLOW = (255, 217, 102)


def angle(u: tuple[int, int, int], v: tuple[int, int, int]):
    dot = u[0] * v[0] + u[1] * v[1] + u[2] * v[2]
    su = u[0] * u[0] + u[1] * u[1] + u[2] * u[2]
    sv = v[0] * v[0] + v[1] * v[1] + v[2] * v[2]
    return dot / math.sqrt(su * sv)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-p", "--image-path", required=True, type=Path)
    args = parser.parse_args()

    pixels = Image.open(args.image_path).convert("RGB").getdata()
    blue_cnt = 0
    yellow_cnt = 0
    for color in pixels:
        if angle(color, BLUE) > angle(color, YELLOW):
            blue_cnt += 1
        else:
            yellow_cnt += 1

    print(f"blue_cnt   = {blue_cnt}")
    print(f"yellow_cnt = {yellow_cnt}")
    print(f"ratio      = {yellow_cnt / blue_cnt}")
