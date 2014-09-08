red_car = new Car('red', [0,0], [0,1])
gray_car = new Car('gray', [2,4], [2,5])
blue_truck = new Truck('blue', [2,2], [3,2], [4, 2])
green_car = new Car('green', [3,1], [4,1])
yello_truck = new Truck('yellow', [1,3], [2,3], [3,3])

lot = new Lot(6, 6, new Spot(6, 3), red_car, gray_car, blue_truck, green_car, yello_truck)
drawLot(lot)