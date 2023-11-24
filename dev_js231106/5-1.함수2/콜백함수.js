const hap = (a, b) => a + b
const minus = (a, b) => a - b

// 고차함수 -> 매개변수에 함수가 들어감 (매개변수 값은 함수 밖에서 호출할 때 결정된다 ->콜백함수)
function account(a, b, action) {
  if (a < 0 || b < 0) {
    //or
    return
  }
  let result = action(a, b)
  return result
}

//action은 콜백함수, 언제 호출될지 모르는 경우에도 콜백함수라고 함.
//전달 당시 바로 호출해서 반환값을 전달하는 것이 아니라 함수를 가리키고 있는 함수의 참조값이 전달
//필요한 순간 호출
console.log(account(1, 2, hap)) //3
console.log(account(1, 2, minus)) //-1
console.log(account(-1, 2, minus)) //undefined
