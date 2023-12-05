import subprocess


def prompt(choices=None, multi=False, preview="", opts=[], delimiter="\n"):
    selection = []

    # convert a list to a string [ 1, 2, 3 ] => "1\n2\n3"
    choices = delimiter.join(map(str, choices)).encode("utf-8")

    if multi:
        opts += ["--multi"]

    if preview:
        opts += ["--preview", preview]

    result = subprocess.run(["fzf", *opts], input=choices, stdout=subprocess.PIPE)

    for line in result.stdout.decode("utf-8").strip().split("\n"):
        if line := line.strip("\n"):
            selection.append(line)

    return selection
