let emp = { key: 'empno' }
let dept = { key: 'deptno' }
let member = { key: 'memberno' }

//배열 합치기
const array = [emp, dept]
console.log(array) //[dept : { key: 'empno' }, emp : {{ key: 'deptno' }}]

//배열복사하기 array copy -> 얕은복사? 깊은복사?

const arrayCopy = [...array]
arrayCopy.push(member)

console.log(array)
console.log(array.length)

console.log(arrayCopy)
console.log(arrayCopy.length)

const arrayCopy2 = [...arrayCopy, { key: 'bookno' }]
console.log(arrayCopy2)
console.log(arrayCopy2.length)

//Object merge
let emp1 = { key1: 'empno' }
let dept1 = { key2: 'deptno' }
let member1 = { key3: 'memberno' }

const object1 = { emp1, dept1 }
console.log(object1);
object1.push  = { member1 }
console.log(object1);

const object2 = {...emp1, ...dept1, ...member1}
console.log(object2);