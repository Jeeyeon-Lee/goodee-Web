var myHeaders = new Headers()
myHeaders.append('Authorization', 'KakaoAK bb648d6cb290a85832f449fed6738ea3')
//사용자가 입력한 정보를 담는 객체 - 사용하기 위해서 method: 'POST'로 변경 필요
//바디속성을 통해 서버에 뭔가 문자열의 형식으로 넘겨줘야 원하는 정보를 받아올 경우 있음.
//예 : 카카오페이, 토스증권 결제서비스 등
// var formdata = new FormData()

var requestOptions = {
  method: 'POST',
  headers: myHeaders,
  body: JSON.stringify({
    name: '나신입',
    email: '신입@hot.com',
  }),
  redirect: 'follow',
}

fetch(
  'https://dapi.kakao.com/v3/search/book?target=title&query=오라클&size=3&=AIzaSyAzxSeXI1gsMWlv9rjkOfzasmyOcux9MX0',
  requestOptions,
)
  .then((response) => response.json()) // json()함수 쓸 수 있음. then은 promise를 반환한다.
  .then((result) => console.log(result))
  .catch((error) => console.log('error', error)) //에러발생시 실행
