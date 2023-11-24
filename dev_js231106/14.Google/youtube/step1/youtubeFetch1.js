const requestOptions = {
  method: 'GET',
  redirect: 'follow',
}
fetch(
  'https://www.googleapis.com/youtube/v3/videos?part=snippet&key=AIzaSyAzxSeXI1gsMWlv9rjkOfzasmyOcux9MX0&maxResults=12&chart=mostPopular',
  requestOptions,
)
  .then(async (response) => {
    const data = await response.json()
    console.log(data)
    console.log(data.items)
    console.log(JSON.stringify(data))
  })
  .catch((error) => console.log('error', error))
