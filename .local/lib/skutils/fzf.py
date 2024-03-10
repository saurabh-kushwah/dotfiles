import subprocess
from typing import List


def prompt(
    choices: List[str] = None,
    multi: bool = False,
    preview_command: str = "",
    opts: List[str] = None,
    delimiter: str = "\n",
) -> List[str]:
    if opts is None:
        opts = []

    # convert a list to a string [ 1, 2, 3 ] => "1\n2\n3"
    choices = delimiter.join(map(str, choices)).encode("utf-8")

    if multi:
        opts += ["--multi"]

    if preview_command:
        opts += ["--preview", preview_command]

    result = subprocess.run(["fzf", *opts], input=choices, stdout=subprocess.PIPE)

    selection = []

    for line in result.stdout.decode("utf-8").strip().split("\n"):
        if line := line.strip("\n"):
            selection.append(line)

    return selection
