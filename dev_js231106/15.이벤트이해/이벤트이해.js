const a = document.querySelector('a')
console.dir(a)
//이벤트 핸들러 이용 시, 두 가지를 같이 작성하면 첫번째 함수가 덮어져서 작동x
a.onclick = () => {
  console.log('링크클릭')
}
a.onclick = () => {
  console.log('링크클릭 다시')
}

//내장함수 이용 시, 위 함수와 같이 두번씩 실행이 됨. 
a.addEventListener('click', () => {
  console.log('링크클릭 again')
})
