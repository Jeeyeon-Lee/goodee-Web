const btns = document.querySelectorAll('.list li')
console.log(btns)

// element idex array
btns.forEach((btn, index) => {
  btn.addEventListener('click', (e) => {
    for (let item of btns) {
      item.classList.remove('on')
    }
    btns[index].classList.add('on')
  })
})

// let i = 1
// //버튼마다 이벤트 넣기
// //인자가 하나일 때 (e) e로 가능
// for (let btn of btns) {
//   btn.addEventListener('click', (e) => {
//     console.log(e.currentTarget)
//     if (i) {
//       //setAtribute?
//       btn.setAttribute('class', 'on')
//       --i
//     } else {
//       btn.setAttribute('class', 'off')
//       ++i
//     }
//   })
// }
