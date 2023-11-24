function Emp(fName,lName){
  //자스는 왜 선언부가 없지? 클래스라는 껍데기가 없기 때문에
  this.fName = fName //자스는 따로 선언안해도 전변선언 가능
  this.lName = lName
}

//프로토타입 정의 시 화살표 함수 x -> this가 달라짐
Emp.prototype.printName = function(){
  return `${this.fName}${this.lName}`
}
const james = new Emp('고수','나')
const king = new Emp('초보','나')
console.log(james.printName()); //'고수나'
console.log(james.printName);   //[Function]
console.log(king.printName());  //'초보나'
console.log(king.printName);    //[Function]