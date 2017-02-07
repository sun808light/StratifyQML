/*
Copyright 2016 Tyler Gilbert

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import StratifyLabs.UI 2.0

TreeView {
    id: control;

    property alias style: properties.style;
    property alias span: properties.span;
    property alias properties: properties;

    property alias striped: control.alternatingRowColors;
    property bool hover: false;
    property bool bordered: false;

    SProperties {
        id: properties;
        blockWidth:  true;
        type: "tree";
        fontWeight: Font.Light;

        onStyleChanged: {
            var items = parseStyle();
            for(var i = 0; i < items.length; i++){
                if( items[i] === "tree-striped" ){
                    striped = true;
                } else if( items[i] === "tree-condensed" ){
                    properties.paddingVertical = StratifyUI.padding_small_vertical;
                } else if( items[i] === "tree-bordered" ){
                    bordered = true;
                }
            }
        }

    }

    // \todo need to apply contextual shading to rows
    // \todo need to replace scroll bars with the scroll bar in STextBox

    implicitHeight: childrenRect.height;
    width: parent.width;

    property real selected: -1;
    property var currentIndex;

    alternatingRowColors: false;
    backgroundVisible: false;


    style: TreeViewStyle {

        backgroundColor: "transparent";
        frame: Rectangle {
            color: "transparent";
            border.color: properties.borderColor;
            border.width: bordered ? 1 : 0;
        }


        scrollBarBackground: Rectangle {
            implicitWidth: 8
            color: "transparent";
        }


        branchDelegate: Item{
            anchors.centerIn: parent;
            width: properties.fontSize + properties.paddingHorizontal*3;
            height: properties.fontSize + properties.paddingVertical*3;

            Text {
                id: branchText;
                anchors.right: parent.right;
                anchors.verticalCenter: parent.verticalCenter;
                color: properties.fontColor;
                font.family: properties.fontIcon;
                text: Fa.Icon.chevron_right;
                rotation: styleData.isExpanded ? 90 : 0;
                state: styleData.isExpanded ? "expanded" : "collapsed";
                states: [
                    State {
                        name: "expanded";
                        PropertyChanges { target: branchText; rotation: 90; }

                    },
                    State {
                        name: "collapsed";
                        PropertyChanges { target: branchText; rotation: 0; }
                    }
                ]


                transitions: Transition {
                    RotationAnimation { duration: 200; direction: RotationAnimation.Shortest; }
                }

            }

            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if( styleData.isExpanded ){
                        control.collapse(styleData.index);
                        branchText.state = "collapsed";
                    } else {
                        control.expand(styleData.index);
                        branchText.state = "expanded";
                    }
                }
            }

        }
        decrementControl: Item{}
        incrementControl: Item{}
        handleOverlap: 0;

        handle: Rectangle {
            implicitWidth: 8;
            color: StratifyUI.gray_lighter;
            radius: width/2;
        }

    }

    clip: true;

    itemDelegate: Text {
        verticalAlignment: Text.AlignVCenter;
        leftPadding: properties.paddingHorizontal;
        rightPadding: properties.paddingHorizontal;
        topPadding: properties.paddingVertical;
        bottomPadding: properties.paddingVertical;
        color: properties.fontColor;
        font.pointSize: properties.fontSize;
        font.family: properties.fontText;
        font.weight: properties.fontWeight;
        text: styleData.value;
        Rectangle {
            color: "transparent";
            anchors.fill: parent;
            border.width: bordered ? 1 : 0;
            border.color: properties.borderColor;
        }
    }

    headerDelegate: Text {
        verticalAlignment: properties.fontVerticalAlignment;
        leftPadding: properties.paddingHorizontal;
        rightPadding: properties.paddingHorizontal;
        topPadding: properties.paddingVertical;
        bottomPadding: properties.paddingVertical;
        color: StratifyUI.gray_base;
        font.pointSize: properties.fontSize;
        font.family: properties.fontText;
        font.weight: Font.Bold;
        text: styleData.value;

        Rectangle {
            anchors.fill: parent;
            color: StratifyUI.body_bg;
            z: -1;
        }

        Rectangle {
            color: "transparent";
            anchors.fill: parent;
            border.width: bordered ? 1 : 0;
            border.color: properties.borderColor;
        }

        Rectangle {
            width: parent.width;
            height: 2;
            color: properties.borderColor;
            border.color: properties.borderColor;
            anchors.bottom: parent.bottom;
        }
    }

    rowDelegate: Rectangle {
        property bool hovered;
        color: (styleData.selected) ? Qt.darker(StratifyUI.body_bg, 1.02 + hovered*0.05) : Qt.darker(StratifyUI.body_bg, 1.0 + hovered*0.05);

        height: properties.fontSize + properties.paddingVertical*3;

        Rectangle {
            width: parent.width;
            height: 1;
            color: properties.borderColor;
            border.color: properties.borderColor;
            anchors.bottom: parent.bottom;
            visible: styleData.row !== (control.rowCount -1);
        }

        /*
            MouseArea {
                anchors.fill: parent;
                hoverEnabled: true;
                onEntered: {
                    hovered = true && control.hover;
                }
                onExited: hovered = false;
                onClicked: {
                    control.rowClicked();
                    control.selected = styleData.row;
                }
            }
            */

    }

}


