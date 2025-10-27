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
            property var glType: (GraphicsInfo.renderableType == GraphicsInfo.SurfaceFormatOpenGLES) ? "OpenGL ES " : "OpenGL "
            text: "Qt WebAssembly is working!\n" +
                  "Platform: " + Qt.platform.os + "\n" +
                  glType + GraphicsInfo.majorVersion + "." + GraphicsInfo.minorVersion
        }
        Text {
            anchors.horizontalCenter: column.horizontalCenter
            text: "\n\nPress F12 to see more details in the Javascript console."
        }
    }
}
