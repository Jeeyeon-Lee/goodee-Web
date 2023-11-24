//객체 생성
// key - 문자, 숫자, 문자열, 심볼
// value - 원시값, 객체(함수)

let sonata ={
  carName : '2024년형 소나타',
  carColor : '검정',
  wheelNum : 4
}

//속성, 데이터 접근 방법 -> 다트연산자, ['']
console.log(sonata.wheelNum); //4
console.log(sonata['carColor']); //검정

//속성추가
sonata.speed = 30
console.log(sonata['speed']); //30

//속성삭제
delete sonata.carColor
console.log(sonata['carColor']); //undefined 