import code
import readline
import rlcompleter

def interact(vars = {}):
    """
     always pass dict(globals(), **locals()) to include caller
     namespace otherwise callers namespace will not be accessible
     in the interactive console.
    """
    vars.update(dict(globals(), **locals()))

    readline.set_completer(rlcompleter.Completer(vars).complete)
    readline.parse_and_bind("tab: complete")

    code.InteractiveConsole(vars).interact()
