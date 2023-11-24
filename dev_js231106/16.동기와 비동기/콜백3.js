//1, 2, 3 순서대로 출력하는 문장 작성하기
console.log(1) //1등

const second = (collback) => {
  setTimeout(() => {
    console.log(2) //2등
    collback()
  }, 2000)
}

const first = () => {
  console.log(3)
}

second(first)
