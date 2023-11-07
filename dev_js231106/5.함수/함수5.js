const a = () => {
  console.log("A");
};
console.log(a);
console.log(a());

const b = (c) => {
  console.log(c);
  c();
};

b(a);