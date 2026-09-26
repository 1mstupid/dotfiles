//@ pragma UseQApplication

import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import "./app_launcher"
import "./power_menu"

ShellRoot {
    // This instantiates the notification toast window.
    NotificationToast {}

    Variants {
        model: Quickshell.screens

        Bar {}
    }
    Variants {
        model: Quickshell.screens
        AppLauncher {
            property var modelData
            screen: modelData
        }
    }
    Variants {
        model: Quickshell.screens
        PowerMenu {
            property var modelData
            screen: modelData
        }
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
