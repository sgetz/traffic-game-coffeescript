#draw vertical lines
drawGrid = ->
    for i in [0...8]
        rec = new fabric.Rect(left: 100*i, top: 0, fill: 'black', width: 2, height: 600, angle: 0)
        C.add(rec)
    for i in [0...8]
        rec = new fabric.Rect(left: 0, top: 100*i, fill: 'black', width: 600, height: 2, angle:0)
        C.add(rec)

drawGrid()