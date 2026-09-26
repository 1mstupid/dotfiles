import QtQuick
import Quickshell

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

            color: clearMa.containsMouse
                   ? Theme.fg
                   : Qt.alpha(Theme.fg, 0.5)

            font.family: Theme.fontFamily
            font.pixelSize: 11

            MouseArea {
                id: clearMa

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

        contentHeight: notifCol.implicitHeight

        clip: true

        Column {
            id: notifCol

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

                delegate: Rectangle {
                    id: card

                    required property var modelData

                    width: notifCol.width
                    height: content.implicitHeight + 14

                    radius: 8

                    color: Qt.alpha(
                        Theme.fg,
                        cardMa.containsMouse ? 0.10 : 0.06
                    )

                    Rectangle {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom

                        anchors.margins: 6

                        width: 3
                        radius: 1.5

                        color:
                            card.modelData.urgency === NotificationUrgency.Critical
                            ? Theme.red
                            : card.modelData.urgency === NotificationUrgency.Low
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

                        spacing: 2

                        Item {
                            width: parent.width
                            height: 14

                            Text {
                                anchors.left: parent.left
                                anchors.right: meta.left
                                anchors.rightMargin: 6

                                text: card.modelData.summary

                                color: Theme.fg

                                font.family: Theme.fontFamily
                                font.pixelSize: 11
                                font.bold: true

                                elide: Text.ElideRight
                            }

                            Row {
                                id: meta

                                anchors.right: parent.right

                                spacing: 8

                                Text {
                                    text: card.modelData.appName ||
                                          card.modelData.appIcon ||
                                          ""

                                    color: Qt.alpha(Theme.fg, 0.4)

                                    font.family: Theme.fontFamily
                                    font.pixelSize: 10
                                }

                                Text {
                                    visible: cardMa.containsMouse

                                    text: "󰅖"

                                    color: dismissMa.containsMouse
                                           ? Theme.red
                                           : Qt.alpha(Theme.fg, 0.5)

                                    font.family: Theme.fontFamily
                                    font.pixelSize: 11

                                    MouseArea {
                                        id: dismissMa

                                        anchors.fill: parent
                                        anchors.margins: -5

                                        hoverEnabled: true

                                        onClicked: {
                                            card.modelData.dismiss()
                                        }
                                    }
                                }
                            }
                        }

                        Text {
                            width: parent.width

                            visible: text !== ""

                            text: card.modelData.body

                            color: Qt.alpha(Theme.fg, 0.65)

                            font.family: Theme.fontFamily
                            font.pixelSize: 11

                            wrapMode: Text.Wrap

                            maximumLineCount: 2
                            elide: Text.ElideRight
                        }
                    }

                    MouseArea {
                        id: cardMa

                        anchors.fill: parent

                        hoverEnabled: true

                        acceptedButtons: Qt.NoButton
                    }
                }
            }
        }
    }
}
