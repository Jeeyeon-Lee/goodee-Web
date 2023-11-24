// 비동기 통신 객체 생성해서 담을 변수 선언
// const 상수->재정의x, 재정의 하고자 하는 것은 변수 let으로 선언 필요
let xhrObject = null

// 비동기 통신객체 생성 함수(js도 예외처리 가능 -> try-catch 사용 가능)
createRequest = () => {
  try {
    xhrObject = new XMLHttpRequest() // 브라우저가 비동기처리를 위해 제공하는 내장객체임
  } catch (error) {
    console.log(error)
  }
  if (xhrObject == null) {
    alert('비동기 통신 객체 생성 에러')
  }
}
// CallBack Function -> 비동기처리 시 가중치
// 콜백함수 생성(조건(0->1->2->3->4) 만족 시 '시스템'이 호출해주는 함수)
// 이벤트처리가 되면 가동되도록 함수 추가 필요
// 개발자가 지정한 콜백함수를 시스템이 알 수 있도록 추가 코딩 필요
accountProcess = () => {
  console.log(`accountProcess 호출 => ${xhrObject.readyState}`)
  if (xhrObject.readyState == 4) {
    if (xhrObject.status == 200) {
      //200 -> OK 20을 읽어온다. boardSellAction.html에서, 나중에는 자바와 스프링에서 진행
      const newTotal = xhrObject.responseText //새로가져온 값 담음
      console.log(`${newTotal}`) //프론트와 백엔드의 접점
      //판매량
      const boardSoldEl = document.querySelector('#boardSold')
      replaceText(boardSoldEl, newTotal) //10이 20으로 바뀜?
      //구매가(cost)
      const costEl = document.querySelector('#cost')
      let cost = getText(costEl)
      //소비자가(price)
      const priceEl = document.querySelector('#price')
      let price = getText(priceEl)
      //마진금액(cash)
      let cashPerBoard = price - cost
      let cash = cashPerBoard * newTotal
      console.log(`마진금액은 ${cash}`)
      //마진금액 붙이기
      const cashEl = document.querySelector('#cash')
      replaceText(cashEl, cash)
    }
  }
}
// 마진 버튼 눌렀을 때 호출
getBoardSold = () => {
  const msg = 'getBoardSold 호출'
  console.log(`${msg}`)
  //비동기 객체 생성
  createRequest()
  //포스트맨으로 연결 가능한건가??? 확인 필요
  // const url = http://127.0.0.1:9000/board/boardSellAcount.jsp
  const url = './boardSellAcount.html'
  //집계 담당 페이지 호출
  xhrObject.open('GET', url, true)
  //콜백 함수 지정 -> 함수도 객체다
  xhrObject.onreadystatechange = accountProcess
  xhrObject.send()
}

// @param - element - 태그정보 - 태그 주소번지
getText = (el) => {
  let text = '' //ES6 ->ECMAScript2015 - 적용안되는 브라우저이면 babel필요하다 또는 번들러 parcel(웹팩-리액트)
  if (el != null) {
    //파라미터 값이 널이니? 존재하니??
    if (el.childNodes) {
      //자바스크립트에서는 0이 아닌 것은 모두 false
      // el null스킵, undefined, "", NaN
      console.log(el + ', ' + el.childNodes.length) //1 1
      for (let i = 0; i < el.childNodes.length; i++) {
        //el.childNodes.length
        //costEl, priceEl
        // 브라우저는 같은 이름이 여러개이면 자동으로 배열로 전환해줌.
        let childNode = el.childNodes[i] //el.childNodes[0], el.childNodes[1]
        //너 텍스트 노드니?
        if (childNode.nodeValue != null) {
          text = text + childNode.nodeValue
        }
      }
    }
  }
  return text
}
//기존 TextNode의 값을 다른 문자열로 바꾸기
/***********************************************
      param1 :document.getElementById("boardSold")
      param1 :document.querySelector("#boardSold")
      param2 :xhrObject. 
************************************************/
replaceText = (el, value) => {
  //el-> boardSoldEl(보드판매량), cashEl(마진)
  if (el != null) {
    //span
    clearText(el) //기존에 있던 10을 지워주세요.
    //새로운 텍스트 노드 15를 생성하기
    var newNode = document.createTextNode(value) //15
    //위에서 생성한 텍스트 노드 값을 el에 붙이는 함수 호출하기
    el.appendChild(newNode) //el boardSoldEl-> <span>10</span> <span id=boardSold or cash></span>  <span>20</span>
  }
}
//기존 태그안에 문자열 지우는 함수 구현
clearText = (el) => {
  if (el != null) {
    if (el.childNodes) {
      //자바스크립트에서는 0이아닌건 모두 참이다
      for (let i = 0; i < el.childNodes.length; i++) {
        let childNode = el.childNodes[i]
        el.removeChild(childNode) //해당 el삭제하기 - DOM API -> 직관적이지 않다-> 유지보수어렵다->쓰기싫다
      }
    }
  }
}
