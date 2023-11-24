/*
동기코드는 순차적으로 실행되는 것 필요
앞에가 진행되어야 코드 실행 가능?
*/

const func = (x)=>{ //x=98 copy by value
  return x+2 //100
}

const x = func(98) //
const y = x //