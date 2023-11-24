// 할당연산자
// 재할당 하려면 let으로 선언하기(변하는 수)
let a = 3;

// (+,*,/,%)= 먼저 계산하고 대입
a = a + 2;
console.log(a);
a += 2;
console.log(a);
a *= 3;
console.log(a);
a %= 3;
console.log(a);
a += 3;
console.log(a);
// 정수를 정수로 나눈 값이 실수로 나와도 바로 1.5로 나옴
a /= 2;
console.log(a);

// 증감연산자
// b++ -> 먼저 출력 나중에 증가
// ++b -> 계산 먼저 나중에 출력
let b = 2;
console.log(b++);
console.log(b);
console.log(--b);
console.log(b);
