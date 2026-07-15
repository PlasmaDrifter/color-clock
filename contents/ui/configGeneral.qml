import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM
import org.kde.kquickcontrols as KQuickControls

KCM.SimpleKCM {
    id: root

    property alias cfg_useCustomColor: useCustomColorCheckbox.checked
    property alias cfg_fontColor: fontColorButton.color
    property alias cfg_useCustomFont: useCustomFontCheckbox.checked
    property string cfg_fontFamily
    property alias cfg_fontBold: fontBoldCheckbox.checked
    property alias cfg_fontItalic: fontItalicCheckbox.checked
    property alias cfg_timeFontSize: timeFontSizeSpinBox.value
    property alias cfg_dateFontSize: dateFontSizeSpinBox.value
    property alias cfg_spacing: spacingSpinBox.value

    Kirigami.FormLayout {
        CheckBox {
            id: useCustomColorCheckbox
            Kirigami.FormData.label: "Custom Font Color:"
            text: "Use custom font color"
        }

        KQuickControls.ColorButton {
            id: fontColorButton
            Kirigami.FormData.label: "Font Color:"
            enabled: useCustomColorCheckbox.checked
        }

        CheckBox {
            id: useCustomFontCheckbox
            Kirigami.FormData.label: "Custom Font Family:"
            text: "Use custom font family"
        }

        ComboBox {
            id: fontFamilyComboBox
            Kirigami.FormData.label: "Font Family:"
            enabled: useCustomFontCheckbox.checked
            model: Qt.fontFamilies().sort()
            editable: true

            Component.onCompleted: {
                currentIndex = model.indexOf(root.cfg_fontFamily)
            }

            onActivated: {
                root.cfg_fontFamily = currentText
            }

            onEditTextChanged: {
                if (activeFocus && model.indexOf(editText) !== -1) {
                    root.cfg_fontFamily = editText
                }
            }

            Connections {
                target: root
                function onCfg_fontFamilyChanged() {
                    fontFamilyComboBox.currentIndex = fontFamilyComboBox.model.indexOf(root.cfg_fontFamily)
                }
            }
        }

        CheckBox {
            id: fontBoldCheckbox
            Kirigami.FormData.label: "Font Weight:"
            text: "Bold text"
        }

        CheckBox {
            id: fontItalicCheckbox
            Kirigami.FormData.label: "Font Style:"
            text: "Italic text"
        }

        SpinBox {
            id: timeFontSizeSpinBox
            Kirigami.FormData.label: "Time Font Size (px):"
            from: 0
            to: 200
            stepSize: 1
            textFromValue: function(value, locale) {
                if (value === 0) {
                    return "Default (16px)";
                }
                return value + " px";
            }
            valueFromText: function(text, locale) {
                if (text.startsWith("Default")) {
                    return 0;
                }
                return parseInt(text);
            }
        }

        SpinBox {
            id: dateFontSizeSpinBox
            Kirigami.FormData.label: "Date Font Size (px):"
            from: 0
            to: 200
            stepSize: 1
            textFromValue: function(value, locale) {
                if (value === 0) {
                    return "Default (11px)";
                }
                return value + " px";
            }
            valueFromText: function(text, locale) {
                if (text.startsWith("Default")) {
                    return 0;
                }
                return parseInt(text);
            }
        }

        SpinBox {
            id: spacingSpinBox
            Kirigami.FormData.label: "Vertical Spacing:"
            from: -50
            to: 50
            stepSize: 1
            textFromValue: function(value, locale) {
                return value + " px";
            }
            valueFromText: function(text, locale) {
                return parseInt(text);
            }
        }
    }
}
