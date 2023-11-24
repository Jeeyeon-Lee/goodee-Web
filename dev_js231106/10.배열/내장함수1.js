/*
ui만 갖고도 단위테스트 가능
*/
const names = ['지연', '제이', '람쥐']

const result = names.toString()
console.log(result)

//join - DOM API의 한계(가독성 떨어짐) -> 양이 늘어나더라도 가독성이 있도록 문자열 탬플릿으로 작성할 때 사용
const result2 = names.join('+')
console.log(result2)
const result3 = names.join(', ')
console.log(result3)

//splice & slice -> 얕은 복사, 깊은 복사의 문제
//splice 하나인것? 원본에 하나가 추가됨
names.splice(1, 0, '지연2')
console.log(names)

//slice
const other = names.slice(1)
console.log(other)
console.log(names)
other.push('요호호')
console.log(other)
console.log(names)
