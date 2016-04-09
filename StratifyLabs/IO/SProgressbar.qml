import QtQuick 2.6
import "SCustomize.js" as Theme

SBaseRectangle {
    property real value: 50;
    //supports success, info, warning, danger, striped, active (animated), stacked

    blockWidth: true;
    bg_color: Theme.progress_bg;
    text_color: Theme.progress_bar_color;
    radius: Theme.progress_border_radius;
    border_color: Theme.progress_bg;

    height: Theme.font_size_base;
    width: parent.width;

    onStyleChanged: {
        var items = style.split(" ");
        radius = Theme.btn_border_radius_base;
        for(var i = 0; i < items.length; i++){
            if( items[i] === "primary" ){
                progress.color = Theme.progress_bar_bg;
            } else if( items[i] === "default" ){
                progress.color = Theme.progress_bar_bg;
            } else if( items[i] === "danger" ){
                progress.color = Theme.progress_bar_danger_bg;
            } else if( items[i] === "success" ){
                progress.color = Theme.progress_bar_success_bg;
            } else if( items[i] === "info" ){
                progress.color = Theme.progress_bar_info_bg;
            } else if( items[i] === "warning" ){
                progress.color = Theme.progress_bar_warning_bg;
            }
        }
    }

    //draw another rectangle in the background
    Rectangle {
        id: progress;
        anchors.left: parent.left;
        anchors.top: parent.top;
        height: parent.height;
        width: parent.width * value*1.0/100.0;
        color: Theme.progress_bar_bg;
        radius: Theme.progress_border_radius;
    }

}
