//forEach API 활용 (https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach)

const fruits = ['🍉', '🥝', '🍓']
fruits.forEach((element) => console.log(element)) //'🍉', '🥝', '🍓'
fruits.forEach((element, i) => console.log(i, element)) //0'🍉', 1'🥝', 2'🍓'
fruits.forEach((element, cnt) => console.log(cnt, element)) //0'🍉', 1'🥝', 2'🍓'
//굳이 이렇게까진 사용x
fruits.forEach((element, cnt, fruits) => console.log(cnt, element, fruits)) //0'🍉'['🍉', '🥝', '🍓'], 1'🥝'['🍉', '🥝', '🍓'], 2'🍓'['🍉', '🥝', '🍓']
fruits.forEach((element, cnt) => {
  console.log(cnt, element)
  document.write(cnt, element)
}) //0'🍉', 1'🥝', 2'🍓'

/*
함수 종류
function funcA(){}   -> 이 함수도 호이스팅이슈 있음. 
funcA =(element, index, array) =>{}       -> Arrow 함수로 이슈해결 

(function funcA(){})();

forEach 구문
forEach(callbackFn)
forEach(callbackFn, thisArg)

callbackFn
배열의 각 요소에 대해 실행할 함수입니다. 반환값은 사용되지 않습니다. 함수는 다음 인수를 사용하여 호출됩니다.

element
배열에서 처리 중인 현재 요소.

index
배열에서 처리 중인 현재 요소의 인덱스.

array
forEach()를 호출한 배열.

thisArg Optional
callbackFn을 실행할 때 this 값으로 사용할 값입니다. 순회 메서드를 참조하세요.
*/
