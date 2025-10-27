import QtQuick
import QtQuick.Window

// main window
Window {
    visible: true
    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("click");
        }
    }

    Column {
        id: column
        anchors {
            fill: parent
            centerIn: parent
        }

        Text {
            anchors.horizontalCenter: column.horizontalCenter
            text: "Qt WebAssembly is working!\n" +
                  "Platform: " + Qt.platform.os + "\n\n" +
                  "Press F12 to see more details in the Javascript console."
        }
        Text {
            anchors.horizontalCenter: column.horizontalCenter
            text: "OpenGL " + GraphicsInfo.majorVersion + "." + GraphicsInfo.minorVersion
        }
    }
}
