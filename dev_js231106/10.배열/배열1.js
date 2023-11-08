// - 연관된 값들을 하나의 그룹으로 묶어서 나열한 자료구조 → Map
// - Array → 내장함수 → 얕은복사, 깊은복사 →forEach문

const colors = ['green', 'white', 'yellow', 'blue']
console.log(colors) //['green', 'white', 'yellow', 'blue']

console.log(colors[0])
console.log(colors[1])
console.log(colors[2])

//배열이 아니라 값 하나씩 꺼내볼 수 있는 forEach문, Map
colors.forEach((color) => {
  console.log(color) // 'green', 'white', 'yellow', 'blue'
})

colors.map((color) => {
  console.log(color) // 'green', 'white', 'yellow', 'blue'
})

const swim = ['자유형', '평영', '배영']
let cnt = 0
console.log(swim[0])
console.log(swim[1])
console.log(swim[2])

swim.forEach((swim) => {
  console.log(swim)
})
swim.forEach(function (swim) {
  console.log(`수영 종류 : ${swim}`)
  cnt++
})

const names = ['지연', '제이', '람쥐']
const copy = []
names.forEach(function (names) {
  console.log(`이름 : ${names}`)
})
for (let i = 0; i < names.length; i++) {
  console.log(`${i}번 : ${names[i]}`)
}

for (let i = 0; i < names.length; i++) {
  copy.push(names[i])
  console.log(`copy[${i}] : ${names[i]}`)
}

//얕은복사 : 주소, 속성, 값 동일하여 원본이 오염될 수 있음. 
const copy2 = names
console.log(names) //['지연', '제이', '람쥐']
console.log(copy2) //['지연', '제이', '람쥐']

//깊은복사 - 새롭게 배열을 추가하여 다른 배열로 생성됨.
copy.push('나제이')
console.log(names) //['지연', '제이', '람쥐']
console.log(copy)  //['지연', '제이', '람쥐', '나제이']
