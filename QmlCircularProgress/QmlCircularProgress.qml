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
    property real progress: 0
    property real radius: 100
    property bool anticlockwise: false
    property alias interval: timer.interval

    width: 2*radius + arcWidth
    height: 2*radius + arcWidth

    Text{
        anchors.centerIn: parent
        font.pointSize: 15
        text: Math.floor((parent.progress / arcAngle) * 100 )+ "%"
    }

    Timer{
        id: timer
        running: false
        repeat: true
        interval: 5
        onTriggered:{
            parent.progress++;
            if (parent.progress > arcAngle){
                onStop();
                return;
            }
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
        timer.running = false;
    }

    onPaint: {
        var ctx = getContext("2d")
        ctx.clearRect(0, 0, width, height)

        var r1      = progress*Math.PI/180
        var startR1 = angleStart*Math.PI/180
        var endR1   = (angleStart+arcAngle)*Math.PI/180
        ctx.beginPath()
        ctx.strokeStyle = arcBackgroundColor
        ctx.lineWidth   = arcWidth
        ctx.arc(width/2, height/2, radius, startR1, endR1, anticlockwise)
        ctx.stroke()

        var r2      = progress*Math.PI/180
        var startR2 = angleStart*Math.PI/180
        var endR2   = startR2+r2
        ctx.beginPath()
        ctx.strokeStyle = arcColor
        ctx.lineWidth   = arcWidth
        ctx.arc(width/2, height/2, radius, startR2, endR2, anticlockwise)
        ctx.stroke()
    }
}



