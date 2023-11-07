// 거짓인거 6가지?
// 1. false
// 2. 0
// 3. null
// 4. undefined
// 5. NaN(Not a Number)
// 6. “”

if (123) {
  console.log("참");
} else {
  console.log("거짓");
}
if (0) {
  console.log("참");
} else {
  console.log("거짓");
}

if (NaN) {
  console.log("참");
} else {
  console.log("거짓");
}

if (null) {
  console.log("참");
} else {
  console.log("거짓");
}

if ("") {
  console.log("참");
} else {
  console.log("거짓");
}

if (undefined) {
  console.log("참");
} else {
  console.log("거짓");
}
