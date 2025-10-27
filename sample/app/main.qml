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

        Canvas {
            anchors.horizontalCenter: column.horizontalCenter
            id: mycanvas
            width: 200
            height: 50
            onPaint: {
                var gl2 = getContext("webgl2");
                if (gl2) {
                    console.log("WebGL2 detected.");
                } else {
                    console.log("WebGL2 NOT detected.");
                }
            }
        }

        Text {
            anchors.horizontalCenter: column.horizontalCenter
            text: "Qt WebAssembly is working!\n" +
                  "Platform: " + Qt.platform.os + "\n\n" +
                  "Press F12 to see more details in the Javascript console."
        }
    }
}
