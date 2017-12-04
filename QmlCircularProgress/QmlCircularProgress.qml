/*!
 *@file QmlCircularProgress.qml
 *@brief Qml圆形进度条
 *@version 1.0
 *@section LICENSE Copyright (C) 2003-2103 CamelSoft Corporation
 *@author zhengtianzuo
*/
import QtQuick 2.4

Canvas {
    id: canvas

    property color arcColor: "#6ACD07"
    property color arcBackgroundColor: "#AAAAAA"
    property int arcWidth: 2
    property int angleStart: 135
    property int arcAngle: 270
    property int valueMax: 500
    property real progress: 0
    property real radius: 100
    property bool anticlockwise: false
    property alias interval: timer.interval

    width: 2*radius + arcWidth
    height: 2*radius + arcWidth

    Text{
        id: canvasValue
        anchors.centerIn: parent
        font.pointSize: 50
        text: parent.progress
        color: getColor(parent.progress)
    }

    Text{
        id: canvasText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: canvasValue.bottom
        anchors.topMargin: 15
        font.pointSize: 20
        text: getText(parent.progress)
        color: getColor(parent.progress)
    }

    Timer{
        id: timer
        running: false
        repeat: true
        interval: 5
        onTriggered:{
            parent.progress++;
            if (parent.progress > parent.valueMax){
                parent.progress = parent.valueMax;
                onStop();
                return;
            }
            arcColor = getColor(progress);
            parent.requestPaint();
        }
    }

    function isRunning(){
        return(timer.running)
    }

    function onStart(){
        progress = 0;
        var ctx = getContext("2d");
        ctx.clearRect(0,0,width,height);
        timer.running = true;
    }

    function onStop(){
        timer.stop();
        timer.running = false;
    }

    onPaint: {
        var ctx = getContext("2d")
        ctx.clearRect(0, 0, width, height)

        var startR1 = angleStart*Math.PI/180
        var endR1   = (angleStart+arcAngle)*Math.PI/180
        ctx.beginPath()
        ctx.strokeStyle = arcBackgroundColor
        ctx.lineWidth   = arcWidth
        ctx.arc(width/2, height/2, radius, startR1, endR1, anticlockwise)
        ctx.stroke()

        var r       = (progress*1.0/valueMax)*arcAngle*Math.PI/180
        var startR2 = angleStart*Math.PI/180
        var endR2   = startR2+r
        ctx.beginPath()
        ctx.strokeStyle = arcColor
        ctx.lineWidth   = arcWidth
        ctx.arc(width/2, height/2, radius, startR2, endR2, anticlockwise)
        ctx.stroke()
    }

    function getColor(input) {
        if((input >= 0) && (input < 51)){
            return "#6ACD07";                         // 一级，优
        } else if((input >= 51) && (input < 101)) {
            return "#FBD028";                         // 二级，良
        }else if((input >= 101) && (input < 151)) {
            return "#FE8700";                         // 三级，轻度污染
        }else if((input >= 151) && (input < 201)) {
            return "#FE0000";                         // 四级，中度污染
        }else if((input >= 201) && (input < 301)) {
            return "#960453";                         // 五级，重度污染
        }else {
            return "#61001D";                         // 六级，严重污染
        }
    }

    function getText(input) {
        if((input >= 0) && (input < 51)){
            return "优";                               // 一级，优
        } else if((input >= 51) && (input < 101)) {
            return "良";                               // 二级，良
        }else if((input >= 101) && (input < 151)) {
            return "轻度污染";                         // 三级，轻度污染
        }else if((input >= 151) && (input < 201)) {
            return "中度污染";                         // 四级，中度污染
        }else if((input >= 201) && (input < 301)) {
            return "重度污染";                         // 五级，重度污染
        }else {
            return "严重污染";                         // 六级，严重污染
        }
    }
}



