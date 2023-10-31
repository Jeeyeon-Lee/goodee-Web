const ajax = new XMLHttpRequest(); //브라우저가 비동기처리를 위해 제공하는 내장객체임
const TITLE_URL = "https://api.hnpwa.com/v0/news/1.json";
const CONTENT_URL = "https://api.hnpwa.com/v0/item/@id.json";
//루트태그
const contatiner = document.getElementById("root");
//뉴스 코멘트 담을 태그 생성하기
const content = document.createElement("div");
//open은 XMLHttpRequest객체가 제공하는 함수로 파라미터는 3개가 필요함
//1)전송방식,2)요청하는URL, 3)true:동기, false:비동기 처리로 요청해줌
//ajax변수는 XMLHttpRequest를 참조하는 변수명임
ajax.open("GET", TITLE_URL, false);
ajax.send(); //send()호출될 때 비로서 서버측에 요청이 일어남
const newsList = JSON.parse(ajax.response); //6번에서 요청했을 때 서버측의 응답을 받아오는 속성이 response임
console.log(newsList); //서버측에서 보낸 응답을 출력해 보기 -Array로 변환하여 출력해줌
const ul = document.createElement("ul"); //DOM  API가지고 태그를 만드니까 직관적이지 않다. DOM Tree그려지지 않아서.
//해시값이 변경될 때 - 인터셉트 - @id ->  Array에 담긴 id값 38012345 변경함
window.addEventListener("hashchange", ()=>{
    console.log("\uD574\uC2DC\uBCC0\uACBD\uB418\uC5C8\uB098???");
    const id = location.hash.substring(1);
    console.log(id);
    ajax.open("GET", CONTENT_URL.replace("@id", id), false);
    ajax.send();
    const ncontent = JSON.parse(ajax.response);
    const title = document.createElement("h1");
    title.innerHTML = ncontent.title;
    content.appendChild(title);
    console.log(ncontent);
});
for(let i = 0; i < 5; i++){
    const li = document.createElement("li");
    const a = document.createElement("a");
    a.href = `#${newsList[i].id}`;
    //console.log(newsList[i].title);
    a.innerHTML = `${newsList[i].title}(\u{1F6A8}${newsList[i].comments_count})`;
    li.appendChild(a);
    ul.appendChild(li);
} //end of for
//화면 두 개로 나눠보기
contatiner.appendChild(ul);
contatiner.appendChild(content);

//# sourceMappingURL=index.c36f364e.js.map
