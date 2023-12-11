import axios from 'axios';
//Insert
export const json = (params) => {
  return new Promise((resolve, reject) => {
    try {
      //axios(object,)
      const response = axios({
        method : 'GET',
        url : 'http://localhost:8000/mime/json.do',
        params : params   //params는 사용자가 입력한 값 -> 예 : 
      })
      resolve(response); //response => [{'mem-name':'나신입', 'mem-email':'na@hot.com'}] =>쿠키나 세션에 담음 
    } catch (error) {
      reject(error);
    }
  });
};

//List
export const memberListDB = (params) => {
  return new Promise((resolve, reject) => {
    try {
      const response = fetch(`http://172.16.2.11:9000/member/memberList`);
      resolve(response);
    } catch (error) {
      reject(error);
    }
  });
};
