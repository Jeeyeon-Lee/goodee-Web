//상품조회->카트담기->주문하기->결제하기->배송하기 순서대로 출력

const 상품조회 = (collback) => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      console.log('상품조회')
      const goods = { name: '스킨', price: 3000 }
      resolve(goods)
    }, 1000)
  })
}

const 카트담기 = () => {
  console.log('카트담기')
}

상품조회().then((response) => {
  console.log(response)
  카트담기()
})

//주문하기, 결제하기, 배송하기
