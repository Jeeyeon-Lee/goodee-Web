//상품조회->카트담기->주문하기->결제하기->배송하기 순서대로 출력

const 상품조회 = (collback) => {
  setTimeout(() => {
    console.log('상품조회')
    collback()
  }, 3000)
}

const 카트담기 = (collback) => {
  setTimeout(() => {
    console.log('카트담기')
    collback()
  }, 3000)
}

const 주문하기 = (collback) => {
  setTimeout(() => {
    console.log('결제하기')
    collback()
  }, 3000)
}
const 결제하기 = (collback) => {
  setTimeout(() => {
    console.log('결제하기')
    collback()
  }, 3000)
}
const 배송하기 = (collback) => {
  setTimeout(() => {
    console.log('배송하기')
    collback()
  }, 3000)
}

상품조회(() => {
  카트담기(() => {
    주문하기(() => {
      결제하기(() => {
        배송하기(() => {})
      })
    })
  })
})
