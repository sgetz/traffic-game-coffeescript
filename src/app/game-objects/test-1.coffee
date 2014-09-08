red_car = new Car('red', [0,0], [0,1])
blue_car = new Car('blue', [2,0], [2,1])
green_car = new Car('green', [3,1], [4,1])
black_truck = new Truck('black', [3,2], [3,3], [3,4])
lot = new Lot(6, 6, new Spot(6, 3), red_car, blue_car, green_car, black_truck)
red_car = new Car('red', [0,0], [1,0])
lot2 = new Lot(6, 6, new Spot(6, 3), red_car)
#console.log lot.repr()
###
red_car = new Car('red', [0,0], [1,0])
console.log red_car.axis
console.log red_car.repr()
console.log red_car.moveForward().repr()
###
lot3 = new Lot(6, 6, new Spot(6, 3), black_truck, green_car)
l=[lot3.repr()]
for newlot in lot3.computeAllPossibleMoves()
    l.push newlot.repr()
console.log l.join('\n')