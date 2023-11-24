const isCar = true
let carName

if (isCar) carName = '소나타'
else carName = '자동차가 아니다'
console.log(carName)

//3항연산자로 바꾸기
{
  let carName = isCar ? '소나타':'자동차가 아니다.';
  console.log(carName)
}
