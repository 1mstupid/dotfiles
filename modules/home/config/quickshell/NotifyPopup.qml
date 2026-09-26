import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Popout {
    id: root

    cardWidth: 340
    cardHeight: Math.min(64 + list.contentHeight, 430)

    property var notifs: Notifications.notifications

    Item {
        id: header

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        height: 22

        Text {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            text: "Notifications"

            color: Theme.accent
            font.family: Theme.fontFamily
            font.pixelSize: 12
            font.bold: true
        }

        Text {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            visible: root.notifs.length > 0

            text: "clear all"

            color: clearMouse.containsMouse
                ? Theme.fg
                : Qt.alpha(Theme.fg, 0.5)

            font.family: Theme.fontFamily
            font.pixelSize: 11

            MouseArea {
                id: clearMouse

                anchors.fill: parent
                anchors.margins: -4

                hoverEnabled: true

                onClicked: Notifications.clearAll()
            }
        }
    }

    Flickable {
        id: list

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: header.bottom
        anchors.topMargin: 8
        anchors.bottom: parent.bottom

        contentHeight: cards.implicitHeight

        clip: true

        Column {
            id: cards

            width: parent.width
            spacing: 6

            Text {
                visible: root.notifs.length === 0

                text: "nothing missed"

                color: Qt.alpha(Theme.fg, 0.35)

                font.family: Theme.fontFamily
                font.pixelSize: 11

                topPadding: 6
            }

            Repeater {
                model: root.notifs

                delegate: NotificationCard {
                    required property var modelData

                    notification: modelData
                }
            }
        }
    }
}
