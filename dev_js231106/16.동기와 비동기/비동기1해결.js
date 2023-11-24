const hap = (a, b, colback) => {
  setTimeout(() => {
    colback(a + b)
    console.log(`hap ${colback(a + b)}`)
  }, 1000)
}

//세번째 인자에 들어가는 콜백함수 선언
const first = (x) => {
  console.log(`first x : ${x}`)
  return x + 1
}

const x = hap(1, 2, first) //
console.log(`x : ${x}`)
const y = x //
console.log(`y : ${y}`)
