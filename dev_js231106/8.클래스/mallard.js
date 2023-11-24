import { Duck } from './duck.js'
export class MallardDuck extends Duck {
  constructor() {
    super('청둥오리', 2) // super 부모의 생성자 호출
  }
}
