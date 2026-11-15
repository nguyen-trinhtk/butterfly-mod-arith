import argparse
import os

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import pandas as pd

STYLE = {
    "baseline": dict(color="#8a8984", marker="o", label="baseline (Givaro)"),
    "barrett": dict(color="#2a78d6", marker="s", label="barrett"),
    "mont":    dict(color="#eb6834", marker="^", label="mont"),
    "fast":    dict(color="#1baf7a", marker="D", label="fast"),
}
TEXT = "#52514e"
GRID = "#e4e3df"


def style_axes(ax, ns):
    ax.set_xscale("log", base=2)
    ticks = [n for n in ns if (n.bit_length() - 1) % 2 == 0]
    ax.set_xticks(ticks)
    ax.set_xticklabels([f"$2^{{{n.bit_length() - 1}}}$" for n in ticks])
    ax.xaxis.set_minor_locator(ticker.NullLocator())
    ax.grid(True, color=GRID, linewidth=0.8)
    ax.set_axisbelow(True)
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)
    for side in ("left", "bottom"):
        ax.spines[side].set_color(TEXT)
    ax.tick_params(colors=TEXT, labelsize=9)


def draw(ax, rows, arith, y):
    style = STYLE[arith]
    ax.plot(rows["n"], y, color=style["color"], marker=style["marker"], markersize=5,
            linewidth=1.5, label=style["label"])
    ax.annotate(arith, (rows["n"].iloc[-1], y.iloc[-1]), xytext=(6, 0), textcoords="offset points",
                va="center", fontsize=9, color=TEXT)


def spread_labels(fig, ax, gap=11):
    fig.canvas.draw()
    labels = sorted(ax.texts, key=lambda text: ax.transData.transform(text.xy)[1])
    to_points = 72 / fig.dpi
    previous = None
    for text in labels:
        y = ax.transData.transform(text.xy)[1] * to_points
        if previous is not None and y < previous + gap:
            text.set_position((6, previous + gap - y))
            y = previous + gap
        previous = y


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("csv")
    parser.add_argument("-o", "--output")
    args = parser.parse_args()
    plots = os.path.join(os.path.dirname(os.path.abspath(args.csv)), "plots")
    output = args.output or os.path.join(plots, os.path.splitext(os.path.basename(args.csv))[0] + ".png")
    os.makedirs(os.path.dirname(os.path.abspath(output)), exist_ok=True)

    data = pd.read_csv(args.csv)
    data = data[data["n"] >= 1 << 10]
    ns = sorted(int(n) for n in data["n"].unique())

    fig, axes = plt.subplots(2, 2, figsize=(11, 7.5), sharex=True)
    for col, op in enumerate(["axpy", "addin"]):
        rows = data[data["op"] == op]
        baseline = rows[rows["arith"] == "baseline"].set_index("n")["ns"]
        top = axes[0][col]
        bottom = axes[1][col]

        for arith in rows["arith"].unique():
            series = rows[rows["arith"] == arith].sort_values("n")
            draw(top, series, arith, series["ns"])
            if arith != "baseline":
                speedup = baseline.loc[series["n"]].values / series["ns"].values
                draw(bottom, series, arith, pd.Series(speedup, index=series.index))

        top.set_yscale("log")
        top.yaxis.set_major_locator(ticker.LogLocator(base=10, subs=(1.0, 2.0, 5.0)))
        top.yaxis.set_major_formatter(ticker.FormatStrFormatter("%g"))
        top.yaxis.set_minor_locator(ticker.NullLocator())
        top.set_title(f"{op}: time per element", loc="left", fontsize=11, color="#0b0b0b")
        top.set_ylabel("ns per element", color=TEXT)
        top.legend(frameon=False, fontsize=9, labelcolor=TEXT)

        bottom.axhline(1, color=STYLE["baseline"]["color"], linewidth=1, linestyle="--")
        bottom.set_ylim(bottom=0)
        bottom.set_title(f"{op}: speedup over baseline (= 1)", loc="left", fontsize=11, color="#0b0b0b")
        bottom.set_ylabel("speedup", color=TEXT)
        bottom.set_xlabel("n", color=TEXT)
        bottom.legend(frameon=False, fontsize=9, labelcolor=TEXT)

        style_axes(top, ns)
        style_axes(bottom, ns)

    fig.suptitle(os.path.relpath(args.csv), x=0.01, ha="left", fontsize=10, color=TEXT)
    fig.tight_layout()
    for ax in axes.flat:
        spread_labels(fig, ax)
    fig.savefig(output, dpi=150, facecolor="white")
    print(output)


if __name__ == "__main__":
    main()
