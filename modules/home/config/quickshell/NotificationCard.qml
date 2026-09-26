import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Rectangle {
    id: root

    required property var notification

    width: parent ? parent.width : 340
    height: content.implicitHeight + 14

    radius: 8

    color: Qt.alpha(
        Theme.fg,
        mouse.containsMouse ? 0.10 : 0.06
    )

    Behavior on color {
        ColorAnimation {
            duration: 120
        }
    }

    // Urgency stripe
    Rectangle {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        anchors.margins: 6

        width: 3
        radius: 1.5

        color:
            root.notification.urgency === NotificationUrgency.Critical
            ? Theme.red
            : root.notification.urgency === NotificationUrgency.Low
            ? Qt.alpha(Theme.fg, 0.25)
            : Theme.accent
    }

    Column {
        id: content

        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: 15
        anchors.rightMargin: 9

        anchors.verticalCenter: parent.verticalCenter

        spacing: 3

        Text {
            width: parent.width

            text: root.notification.summary

            color: Theme.fg

            font.family: Theme.fontFamily
            font.pixelSize: 11
            font.bold: true

            elide: Text.ElideRight
        }

        Text {
            width: parent.width

            visible: text !== ""

            text: root.notification.body

            color: Qt.alpha(Theme.fg, 0.65)

            font.family: Theme.fontFamily
            font.pixelSize: 11

            wrapMode: Text.Wrap

            maximumLineCount: 2
            elide: Text.ElideRight
        }

        Text {
            width: parent.width

            text: root.notification.appName || ""

            color: Qt.alpha(Theme.fg, 0.35)

            font.family: Theme.fontFamily
            font.pixelSize: 9

            elide: Text.ElideRight
        }
    }

    // Whole card dismisses the notification
    MouseArea {
        id: mouse

        anchors.fill: parent

        hoverEnabled: true

        onClicked: {
            root.notification.dismiss()
        }
    }

    // Explicit dismiss button
    Text {
        visible: mouse.containsMouse

        anchors.right: parent.right
        anchors.top: parent.top

        anchors.rightMargin: 8
        anchors.topMargin: 7

        text: "󰅖"

        color: dismissMouse.containsMouse
            ? Theme.red
            : Qt.alpha(Theme.fg, 0.5)

        font.family: Theme.fontFamily
        font.pixelSize: 11

        MouseArea {
            id: dismissMouse

            anchors.fill: parent
            anchors.margins: -5

            hoverEnabled: true

            onClicked: {
                root.notification.dismiss()
            }
        }
    }
}
