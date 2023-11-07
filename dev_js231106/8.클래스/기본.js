//객체를 쉽게 만드는 템플릿
//고전 - 생성자 함수
//클래스 - ES6 -> 클래스 사용빈도 줄어듦 - this 불분명

//클래스 선언
//ES6 이후부터 클래스 내부 함수 가능 -> 에로우 함수로 작성해야함.
class Fruit {
  constructor(name, emoji) {
    this.name = name
    this.emoji = emoji
  }

  display = () => {
    console.log(`${this.name} ${this.emoji}`)
  }
}

//클래스 인스턴스화 - kiwi와 watermelon은 Fruit 클래스의 인스턴스 변수
const kiwi = new Fruit('kiwi', '🥝')
const watermelon = new Fruit('watermelon', '🍉')

console.log(kiwi)
console.log(`${kiwi.name} ${kiwi.emoji}`)
console.log(`${watermelon.name} ${watermelon.emoji}`)
kiwi.display
watermelon.display
