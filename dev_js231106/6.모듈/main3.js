setTimeout( ()=>{
  const temp = await import('.module1.js')
  console.log(temp);
},3000)