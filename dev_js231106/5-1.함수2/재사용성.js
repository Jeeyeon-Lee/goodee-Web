// 백킥 : 문자열, 변수 같이 사용
// let : 변수(재정의, 재할당 가능)
let lastName = "Lee";
let firstName = "jeeyeon";
let foolName = `${lastName} ${firstName}`;
console.log(foolName);
lastName = "Lee";
firstName = "jeehye";
foolName = `${lastName} ${firstName}`;
console.log(foolName);

// 순차적진행 -> 에로우함수는 위에서 사용x, 일반함수는 위에서 사용 가능
console.log(funName2("이", "지연")); //사용 o
console.log(funName("이", "지연")); //defined
// 함수(에로우 함수)
funName = (firstName, lastName) => {
  return `${firstName} ${lastName}`;
};
// 함수(기존작성)
function funName2(firstName, lastName) {
  return `${firstName} ${lastName}`;
}
