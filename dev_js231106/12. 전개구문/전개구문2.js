//전개연산자
//spread operator를 이용해 배열을 복사 -> 깊은 복사

//얜 객체인건지, 배열인건지 무엇인건지??
let depts = [
  {
    0: { deprno: 10, dname: '총무부0', loc: '부산0' },
    1: { deprno: 20, dname: '개발부0', loc: '서울0' },
    2: { deprno: 30, dname: '인사부0', loc: '인천0' },
  },
]

//얜 배열이네
let depts2 = [
  {
    0: { deptno: 10, dname: '총무부', loc: '부산1' },
    1: { deptno: 20, dname: '운영부', loc: '서울1' },
    2: { deptno: 30, dname: '사업부', loc: '경기1' },
  },
  {
    0: { deptno: 40, dname: '총무부', loc: '부산1' },
    1: { deptno: 50, dname: '운영부', loc: '서울1' },
    2: { deptno: 60, dname: '사업부', loc: '경기1' },
  },
]

//유사배열 가능한가???? 어떻게 해야 가져올 수 있지??
//맵으로? forEach로???
const 
depts.forEach((dept, index) => {
  if (index === 0) {
    console.log(dept)
    console.log(dept.dname)
    console.log(dept[0].deptno)
    console.log(dept[0].dname)
    console.log(dept[0]['loc'])
    console.log(dept[0])
    console.log(dept['loc'])
  }
})

depts.forEach((dept, index) => {
  if (index === 1) {
    console.log(dept)
    console.log(dept.dname)
    console.log(dept['loc'])
  }
})
