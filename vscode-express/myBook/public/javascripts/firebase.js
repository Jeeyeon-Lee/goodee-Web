import { initializeApp } from 'https://www.gstatic.com/firebasejs/9.22.1/firebase-app.js';
// initializeApp 함수는 firebase-app.js에서 제공하는 함수
// type = module 기억하기
// import { initializeApp } from 'firebase/app';
//type = module로 해야 모듈 사용 가능
const firebaseConfig = {
  //나는 Object이다. js에는 클래스가 없다.
  apiKey: 'AIzaSyATfx1b1yCgIlUzKrkjdES25MUtYqgTihI',
  authDomain: 'mybook2-70005.firebaseapp.com',
  projectId: 'mybook2-70005',
  storageBucket: 'mybook2-70005.appspot.com',
  messagingSenderId: '642271234688',
  appId: '1:642271234688:web:3ff67d098fc78f6ba7b465',
};

// export 붙여야 외부에서 사용 가능하다.
// Initialize Firebase
export const app = initializeApp(firebaseConfig);
