//닭 -> 달걀 -> 후라이
const getHen = () => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      //비동기처리
      resolve('🐔')
    }, 1000)
  })
}

const getEgg = (hen) => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve(`${hen}=>🥚`)
    }, 1000)
  })
}

const cook = (egg) => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve(`${egg}=>🍳`)
    }, 1000)
  })
}

getHen()
  .then((hen) => getEgg(hen))
  .catch((error) => {
    return 'error' + error
  })
  .then((egg) => cook(egg))
  .then((response) => console.log(response)) //'🐔=>🥚=>🍳'
