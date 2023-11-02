const items = document.querySelector('.items')
const input = document.querySelector('#footer_input')
const btnPlus = document.querySelector('.footer_button')

// 함수(글씨 추가)
plusEvent = () => {
  //사용자가 입력한 텍스트 받아오기(const : 상수/let : 변수/var : 호이스팅 이슈)
  const text = input.value
  console.log(text)
  // == 값만 비교, === 타입까지 비교
  //if문&리턴 -> 아무것도 입력하지 않고 버튼 누를 시 포커스를 input text로 옮기고 함수 탈출
  if (text === '') {
    input.focus() //(커서위치됨)커서 미리 가있으면 마우스로 클릭하지 않고도 즉시 입력 가능
    return
  }
  //새로운 아이템 만들기(텍스트+삭제버튼)
  const item = createItem(text)
  //item 컨테이너에 새로 만든 아이템 추가
  items.appendChild(item)

  //새로 추가된 아이템으로 스크롤링을 이동한다(안보이던 스크롤바가 양이 늘면 블록을 센터로 맞춰줌)
  item.scrollIntoView({ block: 'center' })

  //인풋값 초기화
  input.value = ''
  input.focus() //(커서위치됨)커서 미리 가있으면 마우스로 클릭하지 않고도 즉시 입력 가능
}

// 클릭시 이벤트 함수
btnPlus.addEventListener('click', () => {
  plusEvent()
})

//엔터를 쳤을때도 작동하는 함수 (13번??)  onkeyPress
input.addEventListener('keypress', (e) => {
  if (e.key === 'Enter') {
    plusEvent()
  }
})

//DOM html의 코드에 따른 함수 생성 -> 번거로움..
// function createItem(text) {
createItem = (text) => {
  // DOM에서 제공하는 함수를 이용한 태그 생성
  const itemRow = document.createElement('li')
  //setAttribute() : 태그에 속성 추가
  itemRow.setAttribute('class', 'item_row')
  const item = document.createElement('div')
  item.setAttribute('class', 'item')
  const name = document.createElement('span')

  //추가하기
  name.setAttribute('class', 'item_name')
  name.innerText = text
  const deleteBtn = document.createElement('button')

  //삭제하기
  deleteBtn.setAttribute('class', 'item_delete')
  deleteBtn.innerHTML = '<i class="fa-solid fa-trash"></i>' //   i 태그는 속성으로 추가

  //createItem 호출되었을 때, 화면이 먼저 완성되고(랜더링 ==DOM TREE)되고
  //나서 버튼이 눌러지니, 그 이후 파라미터의 itemRow는 createItem함수에서 생성된 전부를 쥐고 있음.
  deleteBtn.addEventListener('click', () => {
    items.removeChild(itemRow)
  })

  //밑줄긋기
  const itemDivider = document.createElement('div')
  itemDivider.setAttribute('class', 'item_divider')

  //붙이기
  item.appendChild(name)
  item.appendChild(deleteBtn)
  itemRow.appendChild(item)
  itemRow.appendChild(itemDivider)
  return itemRow
}
