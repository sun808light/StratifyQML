import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Alerts";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            EHeading {
                title: "Alerts";
                inherits: "QtQuick.Controls 2.0 Rectangle";
                stratifyName: "SAlert";
                defaultSize: "block";
            }

            SLabel { style: "left"; text: "Alert Colors:"; }
            AlertExampleColors{}
            ECodeExample { source: "AlertExampleColors"; }

            SHLine{}

            SLabel { style: "left"; text: "Alert Options:"; }
            AlertExampleOptions{}
            ECodeExample { source: "AlertExampleOptions"; }
        }
    }
}
