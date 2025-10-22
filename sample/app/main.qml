import QtQuick 2.3
import QtQuick.Window 2.2

// main window
Window {
    visible: true
    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log('click');
        }
    }

    Rectangle {
        anchors.fill: parent
        Text {
            anchors.centerIn: parent
            text: "Qt WebAssembly is working!\nPlatform: " + Qt.platform.os + "\n\nCheck the Javascript console for more details."
        }
    }
}
