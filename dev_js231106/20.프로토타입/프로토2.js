const person = {
  firstName: '초보', lastName: '나',
  printName: function () {
    return `${this.firstName}${this.lastName}`
  },
}
const student = {
  firstName: '신입', lastName: '나',
}

console.log(person.printName()) //초보나
// console.log(student.printName()) //호출 불가 그럼 어떻게??
// 함수도 객체이다. 함수의() 빼고(일급함수, 일급객체) 
// 다트로 call하여 파라미터에 넣어 함수 사용 가능 
console.log(person.printName.call(student)) //신입나

