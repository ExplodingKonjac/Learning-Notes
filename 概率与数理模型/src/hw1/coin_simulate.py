import random
from enum import Enum


class Direction(Enum):
    UP = 0
    DOWN = 1


def simulate(n: int):
    cnt = 0
    for _ in range(n):
        result = random.choice((Direction.UP, Direction.DOWN))
        if result == Direction.UP:
            cnt += 1
    print(f"n = {n:<5}, n_H = {cnt:<5}, frequency = {cnt / n:.4f}")


if __name__ == "__main__":
    simulate(2000)
    simulate(4000)
    simulate(12000)
    simulate(24000)
