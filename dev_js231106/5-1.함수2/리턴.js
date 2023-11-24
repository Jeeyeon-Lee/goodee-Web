function hap(a, b) {
  return undefined
}
console.log(hap(1, 3))

//return을 함수 중간에 만나면 함수가 종료

//전달되는 것이 유효성 체크(예:음의 정수는 계산x)
function m(num) {
  if (num > 0) {
    console.log(num)
  } else {
    return
  }
}
console.log(m(4))
console.log(m(-4))
