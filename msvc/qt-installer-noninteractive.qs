function Controller() {
    installer.autoRejectMessageBoxes();
    installer.installationFinished.connect(function() {
        gui.clickButton(buttons.NextButton, 3000);
    })
    installer.setMessageBoxAutomaticAnswer("cancelInstallation", QMessageBox.Yes);
}

Controller.prototype.WelcomePageCallback = function() {
    gui.clickButton(buttons.NextButton, 3000);
}

Controller.prototype.CredentialsPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.IntroductionPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.TargetDirectoryPageCallback = function()
{
    gui.clickButton(buttons.NextButton);
}

// REF: https://download.qt.io/online/qtsdkrepository/windows_x86/desktop/qt5_5151/
Controller.prototype.ComponentSelectionPageCallback = function() {
    var widget = gui.currentPageWidget();
    widget.deselectAll();
    widget.selectComponent("qt.qt5.5151.qtcharts")
    widget.selectComponent("qt.qt5.5151.qtwebengine")
    widget.selectComponent("qt.qt5.5151.win64_msvc2019_64")
    widget.selectComponent("qt.qt5.5151.qtcharts.win64_msvc2019_64")
    widget.selectComponent("qt.qt5.5151.qtwebengine.win64_msvc2019_64")
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.LicenseAgreementPageCallback = function() {
    gui.currentPageWidget().AcceptLicenseRadioButton.setChecked(true);
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.StartMenuDirectoryPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.ReadyForInstallationPageCallback = function()
{
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.FinishedPageCallback = function() {
var checkBoxForm = gui.currentPageWidget().LaunchQtCreatorCheckBoxForm
if (checkBoxForm && checkBoxForm.launchQtCreatorCheckBox) {
    checkBoxForm.launchQtCreatorCheckBox.checked = false;
}
    gui.clickButton(buttons.FinishButton, 5000);
}