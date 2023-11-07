// express 모듈의 제약사항이 있어서 파일이 저장된 경로 잘 확인해야함.
import axios from 'axios';
import {
  getAuth,
  GithubAuthProvider,
  GoogleAuthProvider,
} from 'https://www.gstatic.com/firebasejs/9.22.1/firebase-auth.js';
class AuthLogic {
  constructor() {
    this.auth = getAuth();
    this.gitProvider = new GithubAuthProvider();
    this.googleProvider = new GoogleAuthProvider();
  }
  getUserAuth = () => {
    return this.auth;
  };
  getGithubAuthProvider = () => {
    return this.gitProvider;
  };
  getGoogleAuthProvider = () => {
    return this.googleProvider;
  };
}
//default 하나밖에 export 안 된다
export default AuthLogic;

//카카오 인증요청하기(전처리 필요)
export const loginKakao = (params) => {
  return new Promise((resolve, reject) => {
    try {
      const response = axios({
        method: 'get',
        url: '카카오토큰을 받아올 URL주소 -카카오개발자 센터 긁어옴',
        params: params,
      });
      console.log(response);
      resolve(response);
    } catch (error) {
      reject(error);
    }
  });
}; //end of loginKakao
//구글 인증요청하기(전처리 필요)
export const loginGoogle = (params) => {
  return new Promise((resolve, reject) => {
    signInWithEmailAndPassword(auth, googleProvider)
      .then((result) => {})
      .catch((error) => {
        const errorCode = error.code;
        const errorMessage = error.message;
      });
  });
}; //end of loginGoogle
