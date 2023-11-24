//리액트 상태관리 리덕스 라이브러리 컨셉 플럭스 아키텍처? JS로 구현 중인 코드

//함수 안의 함수 선언 가능
// {} - 객체, 참조형, 함수도 들어갈 수 있음.
// , - 열거형 연산자
const createStroe = () => {
  let state //상태관리
  let handlers = []
  const send = () => {}
  //구독해줘를 함수에 담아->영속성, 유지
  const subscribe = (a) => {
    handlers.push(a)
  }
  return {
    send,
    subscribe,
  }
}
//store 상수 안에 리턴값인 함수 두개 들어감
const store = createStroe()
console.log(store)

//함수호출은 아래와 같이?
store.subscribe(() => {
  console.log('subscribe')
})

store.send()
