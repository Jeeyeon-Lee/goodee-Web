/*
sort() : 알파벳순으로 요소 정렬
      reverse() :  역순으로 요소 정렬
      sort((a,b) => {return a-b}) : 올림차순으로 정렬
      sort((a,b) => {return b-a}) : 내림차순으로 정렬
      sort((a,b) => {return a-b})[0] : 최소값 반환
      sort((a,b) => {return b-a})[0] : 최대값 반환

주로 사용 ; 숫자정렬
      */

//sort 사용을 통한 정렬1
const names = ['지연', '제이', '람쥐']
console.log(names.sort())

const nums = [5, 6, 7, 8, 9, 3]

//sort 사용을 통한 정렬2
nums.sort(function (a, b) {
  return a - b
})
console.log(nums)

//Arrow function으로 전환
nums.sort((a,b)=>{a-b})