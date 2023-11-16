//Insert
export const memberInsertDB = (params) =>{
  return new Promise((resolve, reject) => {
    try {
      const response = fetch(`http://172.16.2.11:9000/member/memberInsert`)
      resolve(response)
    } catch (error) {
      reject(error)
    }
  })
}

//List
export const memberListDB = (params) =>{
  return new Promise((resolve, reject) => {
    try {
      const response = fetch(`http://172.16.2.11:9000/member/memberList`)
      resolve(response)
    } catch (error) {
      reject(error)
    }
  })
}