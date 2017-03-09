import QtQuick 2.0
import StratifyLabs.UI 2.0

SContainer {
  property alias source: code.source;
  style: "block fill";
  SColumn {
    style: "block fill";
    SRow {
      SButton {
        span: STheme.isScreenSm ? 2 : 6;
        style: "left btn-naked";
        text: "Back";
        icon: Fa.Icon.chevron_left;
        onClicked: showContent();
      }

      SButton {
        span: STheme.isScreenSm ? 2 : 6;
        style: "right btn-outline-secondary";
        text: "Copy";
        icon: Fa.Icon.copy;
        onClicked: {
          //copy content of code example to clipboard
          code.textArea.copy();
        }
        SToolTip {
          text: "Copy Selected Code";
        }
      }
    }
    ECodeExample {
      style: "block fill";
      span: 12;
      id: code;
    }
  }
}
