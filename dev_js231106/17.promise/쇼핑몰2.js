//상품조회->카트담기->주문하기->결제하기->배송하기 순서대로 출력

const 상품조회 = () => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      console.log('상품조회')
      const goods = { name: '스킨', price: 3000 }
      resolve(goods)
    }, 1000)
  })
}

const 카트담기 = () => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      console.log('카트담기')
      const older = {
        name: '스킨',
        name2: '샴푸',
        name3: '비누',
        name4: '츄리닝',
      }
      resolve(older)
    }, 1000)
  })
}

상품조회()
  .then((response) => {
    console.log(response) //{name: '스킨', price: 3000 }
    console.log(response.name) //'스킨'
    console.log(response.price) //3000
    return 카트담기()
  })
  .then((response) => {
    console.log(response)
    console.log(response.name)
    console.log(response.name2)
    console.log(response.name3)
    console.log(response.name4)
    return 결제하기()
  })

const 결제하기 = () => {
  console.log('결제하기')
}
