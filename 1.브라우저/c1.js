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
})
