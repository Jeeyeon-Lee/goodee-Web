//1, 2, 3 순서대로 출력하는 문장 작성하기


console.log(1) //1등

setTimeout(() => {
  console.log(2) //2등
  first() //3등
}, 2000)

const first = () => {
  console.log(3)
}
