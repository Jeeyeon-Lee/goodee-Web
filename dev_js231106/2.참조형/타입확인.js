const a = 123;
console.log(typeof a);

// 문자열 타입체크 시 string
console.log(typeof "이순신" == "string");
console.log(typeof "이순신" === "String");
console.log(typeof "이순신" === "string");
console.log(typeof undefined == "undefined");
console.log(typeof undefined === "undefined");
console.log(typeof null == "object");
// 배열
console.log(typeof [] == "object");
console.log(typeof [] == Object);
// 객체
console.log(typeof {} == "object");
// 함수
console.log(typeof function () {} == Object);
console.log(typeof function () {} == "function");
console.log([].constructor === Array);
console.log([].constructor == Array);
console.log({}.constructor === Object);
