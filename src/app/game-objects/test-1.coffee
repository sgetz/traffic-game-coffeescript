red_car = new Car('red', [0,0], [0,1])
blue_car = new Car('blue', [2,0], [2,1])
green_car = new Car('green', [3,1], [4,1])
black_truck = new Truck('black', [3,2], [3,3], [3,4])
lot = new Lot(6, 6, new Spot(6, 3), red_car, blue_car, green_car, black_truck)

console.log lot.repr()