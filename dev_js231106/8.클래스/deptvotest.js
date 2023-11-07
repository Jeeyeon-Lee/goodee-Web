//import {클래스이름} from '위치경로'
import { DeptVO } from './deptvo.js'

const dvo = new DeptVO(30, '개발부', '서울')
console.log(dvo)
console.log(dvo.getDeptno)
console.log(dvo.getDname)
console.log(dvo.getLoc)

dvo.setDeptno = 40
console.log(dvo.getDeptno)
console.log(dvo)
