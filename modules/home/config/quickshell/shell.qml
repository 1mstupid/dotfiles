//@ pragma UseQApplication

import Quickshell
import Quickshell.Io

ShellRoot {
    // This instantiates the notification toast window.
    NotificationToast {}

    Variants {
        model: Quickshell.screens

        Bar {}
    }

    property var notifications: Notifications.notifications

    IpcHandler {
        target: "wm"

        function applyGaps(): void {
            Wm.applyGaps(Wm.gaps)
        }

        function applyEffects(): void {
            Wm.applyEffects()
        }
    }
}
