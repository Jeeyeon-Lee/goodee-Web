const vertical = document.querySelector('.vertical')
const horizontal = document.querySelector('.horizontal')
const target = document.querySelector('.target')
const label = document.querySelector('.label')
// => 에로우 function
addEventListener('load', () => console.log('test'))
const domRect = target.getBoundingClientRect()
// const 상수선언, let 변수선언
const twidth = domRect.width
const theight = domRect.height
console.log(`${twidth}, ${theight}`)
//백킥 `` (물결표시 밑)
document.addEventListener('mousemove', (event) => {
  const x = event.clientX
  const y = event.clientY
  console.log(`${event.clientX},${event.clientY}`)
  //문제제기-좌표값이 출력은 되지만 가로, 세로 선이 그대로임.
  vertical.style.left = `${x}px`
  horizontal.style.top = `${y}px`
  target.style.top = `${y}px`
  target.style.left = `${x}px`
  label.style.top = `${y}px`
  label.style.left = `${x}px`

  //label.innerHTML = `(100px, 200px)` 작동하는지 확인용
  label.innerHTML = `(${x}px, ${y}px)`
  //   {} 안에는 변수만 올 수 있음. 문자열은 그 뒤에 붙여서 사용하면 됨.
})
