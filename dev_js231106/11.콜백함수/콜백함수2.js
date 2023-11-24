// 모든 업무에는 처리 순서가 있음.
// 입력 -> 처리 -> 출력

// 파라미터자리에 함수를 보내서 무조건 해당 순서대로 진행되도록 코드를 짤 수 잇음.
// function first(param){}
first = (param) => {
  console.log('1')
  param()
}
second = () => {
  console.log('2')
}
first(second)
//first 지연 발생 없음 
