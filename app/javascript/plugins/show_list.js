const showList = () => {
  const restList = document.querySelector('#temp-list')
  if (restList) {
    // it is a string. need to convert into array of objects
    const restsArr = JSON.parse(window.localStorage.list)
    // restList.innerHTML = localStorage.getItem("list")
    restsArr.forEach((obj) => {
      // console.log(obj.restName);
      restList.insertAdjacentHTML("beforeend", `<li>${obj.restName}</li>`)
      // restList.innerHTML = obj.restName;
    })
    // console.log(restsArr);
  }
}

export const getList = () => {
  return window.localStorage.list
}


export { showList }
