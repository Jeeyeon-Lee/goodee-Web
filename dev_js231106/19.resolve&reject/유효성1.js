//Promise의 resolve, reject 흉내내보기

const validFunc = (index, cb, errorCb) => {
  setTimeout(() => {
    if (index > 10) {
      errorCb(`${index}는 10보다 클 수 없습니다.`)
      return;
    }
    console.log(index)
    cb(index + 1)
  }, 1000)
}

validFunc(4,res=>console.log(res),err=>console.log(err))
validFunc(15,res=>console.log(res),err=>console.log(err))