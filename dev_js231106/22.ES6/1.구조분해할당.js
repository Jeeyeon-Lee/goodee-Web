//구조분해할당
//https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment
//object

const Sonata = {
  carColor: 'black',
  speed: 30,
}

//1단계 : 기본적인 초기화 방법
const carColor = Sonata.carColor
console.log(carColor)
const speed = Sonata.speed
console.log(speed)

//위의 초기화 방법은 비효율적 ->  구조분해 할당 사용해보기
//2단계 : 한번에 생성 가능
{
  //스코프로 감싸면 이름충돌 막음.
  const { carColor, speed } = Sonata
  console.log(carColor, speed)
}

//3단계 : 다른 이름으로 사용 가능
{
  //스코프로 감싸면 이름충돌 막음.
  const { carColor : myColor, speed : mySpeed } = Sonata
  console.log(myColor, mySpeed)
}

const fruits = ['🍎','🍋','🍇']

//1단계 : 기본적 초기화
const first = fruits[0]
const second = fruits[1]
const third = fruits[2]

{
  const[first, second, third] = fruits
  console.log(first, second, third);
}