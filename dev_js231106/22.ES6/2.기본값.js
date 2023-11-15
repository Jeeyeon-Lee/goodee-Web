//https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Functions/Default_parameters
const msgPrint = (msg) => {
  if ((mst = null)) {
    mst = 'default message'
  }
  console.log(msg) //'🤚' undefined '📖'
}

msgPrint('🤚')
msgPrint()
msgPrint('📖')

{
  const msgPrint = (msg='default message') => {
    console.log(msg) //'🤚' 'default message' '📖'
  }
  msgPrint('🤚')
  msgPrint()
  msgPrint('📖')
}