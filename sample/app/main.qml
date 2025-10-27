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

    Column {
        id: column
        anchors {
            fill: parent
            centerIn: parent
        }

        Canvas {
            //anchors.centerIn: column
            id: mycanvas
            width: 200
            height: 50
            onPaint: {
                var ctx = getContext("2d");
                ctx.fillStyle = Qt.rgba(1.0, 0.5, 0.5, 1);
                ctx.fillRect(0, 0, width, height);

                var gl2 = getContext("webgl2");
                if (gl2) {
                    console.log("WebGL2 detected.");
                } else {
                    console.log("WebGL2 NOT detected.");
                }
            }
        }

        Text {
            //anchors.centerIn: column
            text: "Qt WebAssembly is working!\n" +
                  "Platform: " + Qt.platform.os + "\n\n" +
                  "Press F12 to see more details in the Javascript console."
        }
    }
}
