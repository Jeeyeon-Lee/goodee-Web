//prototype

const fruits = ['🍓', '🥝', '🍎']
const fruits2 = new Array('🍌', '🍇', '🍋')

console.log(fruits) //['🍓', '🥝', '🍎']
console.log(fruits2) //['🍌', '🍇', '🍋']
console.log(fruits2.includes('🍇')) //true(존재함)
console.log(fruits2.includes('🍓')) //false(존재x)

Array.prototype.method = function () {
  console.log(this) //['🍓', '🥝', '🍎']['🍌', '🍇', '🍋']
}

fruits.method()
fruits2.method()

const arr = []
arr.method()
