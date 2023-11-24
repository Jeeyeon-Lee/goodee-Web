import number, { Sonata, fruits, hap, str } from "./module1.js";
console.log(number);
console.log(str);
console.log(fruits);
console.log(fruits.length);
fruits.push("🍎");
console.log(fruits);
console.log(fruits.length);

//전변을 정의하지 않아도 this를 통해 초기화하여서
//클래스
const myCar = new Sonata();
console.log(myCar.speed);
console.log(myCar.wheelNum);
myCar.speedUp();
console.log(myCar.speed);
//없는 요소여서 undefined
console.log(myCar.carColor);

//함수
console.log(hap(3, 4));
