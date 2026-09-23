#!/usr/bin/env python3
from Xlib import X, display
from Xlib.protocol import event
import subprocess
import os

d = display.Display()
root = d.screen().root
root.change_attributes(event_mask=X.PropertyChangeMask)

SCRIPT = os.path.expanduser("~/.config/eww/scripts/dwm-empty-workspace.sh")

def check_empty():
    result = subprocess.run([SCRIPT], capture_output=True, text=True)
    output = result.stdout.strip()
    print(output, flush=True)
    return output

def reset_hidden():
    subprocess.run(["eww", "update", "pomo-manual-hidden=false"], capture_output=True)
    subprocess.run(["eww", "update", "task-manual-hidden=false"], capture_output=True)
    subprocess.run(["eww", "update", "clock-manual-hidden=false"], capture_output=True)


prev = "unknown"

current = check_empty()

while True:
    ev = root.display.next_event()
    if ev.type == X.PropertyNotify:
        if ev.atom in (d.intern_atom('_NET_CURRENT_DESKTOP'),
                       d.intern_atom('_NET_CLIENT_LIST'),
                       d.intern_atom('_NET_ACTIVE_WINDOW')):
            current = check_empty()
            if current == "false" and prev == "true":
                reset_hidden()
            prev = current
