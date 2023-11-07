import { initializeApp } from 'https://www.gstatic.com/firebasejs/9.22.1/firebase-app.js';
// import { initializeApp } from 'firebase/app';
const firebaseConfig = {
  apiKey: 'AIzaSyCltWlMRHeCS61FnAfLs3B-hsgaK_o5Nl0',
  authDomain: 'goodee-project-b2af0.firebaseapp.com',
  projectId: 'goodee-project-b2af0',
  storageBucket: 'goodee-project-b2af0.appspot.com',
  messagingSenderId: '457035965872',
  appId: '1:457035965872:web:dc2ccf6a403dd450d0e275',
};

// Initialize Firebase
export const app = initializeApp(firebaseConfig);
