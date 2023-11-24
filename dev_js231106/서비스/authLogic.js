// express 모듈의 제약사항이 있어서 파일이 저장된 경로 잘 확인해야함.
import {
  getAuth,
  GithubAuthProvider,
  GoogleAuthProvider,
  signInWithPopup,
} from 'https://www.gstatic.com/firebasejs/9.22.1/firebase-auth.js'
class AuthLogic {
  constructor() {
    this.auth = getAuth()
    this.gitProvider = new GithubAuthProvider()
    this.googleProvider = new GoogleAuthProvider()
  }
  getUserAuth = () => {
    return this.auth
  }
  getGoogleAuthProvider = () => {
    return this.googleProvider
  }
} //end of AuthLogic
export default AuthLogic
//import {loginGoogle,loginKakao,logout} from "./service/authLogic.js"
//(내가작성한 코드가 아니라 외부에서 API 가져와서 사용하는 거라면)
//클래스 주소번지 없이 (어디서?html, js)에 호출하고 싶다면 함수선언 앞에 export 붙이기?

//auth(firebase)->app->getAuth(this.auth = getAuth) : 사용자 정보를 갖고 있음.
//이걸 토대로(인증이 된 상태로) 로그아웃을 할 수 있도록 이벤트를 넣어야 함.

//구글 로그아웃
export const logout = (auth) => {
  //구글서버 해당 사용자 로그아웃 요청
  //-> resolve(응답) / reject(거절) -> 여기서 응답과 거절 또한 객체, 콜백함수
  return new Promise((resolve, reject) => {
    auth.signOut().catch((e) => reject(alert(e + ':로그아웃 에러 발생')))
    localStorage.removeItem('uid')
    localStorage.removeItem('displayName')
    localStorage.removeItem('email')
    resolve()
  })
}

//구글 인증요청하기(전처리 필요)
export const loginGoogle = (auth, googleProvider) => {
  return new Promise((resolve, reject) => {
    console.log('googleProvider 호출 성공')
    console.log(googleProvider)
    signInWithPopup(auth, googleProvider)
      .then((result) => {
        // 안보임
        console.log(result)
        // 보임
        console.log(JSON.stringify(result))
        const user = result.user
        localStorage.setItem('uid', user.uid)
        localStorage.setItem('displayName', user.displayName)
        localStorage.setItem('email', user.email)
        resolve(user)
      })
      .catch((error) => {
        reject(error)
      })
  })
} //end of loginGoogle

//파이어베이스 인증에 등록해둔 이메일과 비번으로 로그인
export const loginEmail = (params) => {
  return new Promise((resolve, reject) => {
    signInWithEmailAndPassword(auth, googleProvider)
      .then((result) => {})
      .catch((error) => {
        const errorCode = error.code
        const errorMessage = error.message
      })
  })
} //end of loginGoogle

//카카오 인증요청하기(전처리 필요)
export const loginKakao = (params) => {
  return new Promise((resolve, reject) => {
    try {
      const response = axios({
        method: 'get',
        url: '카카오토큰을 받아올 URL주소 -카카오개발자 센터 긁어옴',
        params: params,
      })
      console.log(response)
      resolve(response)
    } catch (error) {
      reject(error)
    }
  })
} //end of loginKakao
