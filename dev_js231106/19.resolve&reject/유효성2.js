//Promise의 resolve, reject 흉내내보기

const validFunc = (index) => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      if (index > 10) {
        reject(`${index}는 10보다 클 수 없습니다.`)
        return
      }
      console.log(index)
      resolve(index + 1)
    }, 1000)
  })
}

validFunc(5)
  .then((res) => console.log(res))
  .catch((err) => console.error(err))

validFunc(15)
  .then((res) => console.log(res))
  .catch((err) => console.error(err))
