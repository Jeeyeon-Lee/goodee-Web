const colors = ['red', 'yellow', 'green']

//ES5 : 변수 하나하나 호출 -> 코드양 많음(비효율)
const color1 = colors[0]
const color2 = colors[1]
const color3 = colors[2]
console.log(color1, color2, color3) //'red', 'yellow', 'green'

//ES6 : 구조분해할당을 사용하여 개선 (배열, 객체 다 가능)
//1.배열
const [c1, c2, c3] = colors
console.log(c1, c2, c3) //'red', 'yellow', 'green'

//2.객체
const dept = {
  deptno: 10,
  dname: '개발부',
  loc: '서울',
}
const { deptno, dname, loc } = dept
console.log(dept) //{deptno: 10, dname: '개발부',loc: '서울'}

//ES5시절
console.log(dept.deptno)
console.log(dept['deptno'])
console.log(dname)
console.log(loc)
