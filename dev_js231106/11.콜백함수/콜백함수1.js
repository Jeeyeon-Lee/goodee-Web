// 모든 업무에는 처리 순서가 있음.
// 입력 -> 처리 -> 출력
first = () => {
  console.log('1')
}
second = () => {
  console.log('2')
}
first()
//first 함수의 지연 발생
second()
