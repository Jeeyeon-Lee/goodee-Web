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
//에러처리 - > try-catch문
const wrapping = async () => {
  try {
    const res = await validFunc(5)
    console.log(res)
  } catch (error) {
    console.error(error)
  } finally {
    //정상, 실패 상관 없이 실행됨.
    console.log('처리완료')
  }
}
wrapping()

/*
validFunc(5)
  .then((res) => console.log(res))
  .catch((err) => console.error(err))
  .finally(() => console.log('처리완료'))

validFunc(15)
  .then((res) => console.log(res))
  .catch((err) => console.error(err))
  .finally(() => console.log('처리완료'))
*/
