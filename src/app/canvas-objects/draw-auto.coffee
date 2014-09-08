


drawAuto = (auto) ->
    [width, height] = if auto.axis == Axis.X then [100*auto.size, 100] else [100, 100*auto.size]
    top = 0
    left = 0
    if auto.axis == Axis.Y
        top = (6 - auto.getForwardSpot().y) * 100
        left = (auto.getForwardSpot().x ) * 100
    if auto.axis == Axis.X
        top = (5 - auto.getBackwardSpot().y ) * 100
        left = (auto.getBackwardSpot().x + 1)* 100
        
    rec = new fabric.Rect(left: left, top: top, fill: auto.color, width: width, height: height, angle: 0)
    C.add(rec)

drawLot = (lot) ->
    for own autoName, auto of lot.configuration
        drawAuto(auto)
        
