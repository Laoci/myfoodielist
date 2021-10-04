const showList = () => {
  const restList = document.querySelector('#temp-list')
  if (restList) {
    // it is a string. need to convert into array of objects
    const restsArr = JSON.parse(window.localStorage.list)
    // restList.innerHTML = localStorage.getItem("list")
    restsArr.forEach((obj) => {
      restList.insertAdjacentHTML("beforeend", `<li>${obj.restName}</li>`)
    })
    deleteList();
  }
}

// export const getList = () => {
//   return window.localStorage.list
// }

const deleteList = () => {
  // when click on clear link
  const deleteL = document.querySelector('.deleteL')
  deleteL.addEventListener('click', (e) => {
    window.localStorage.clear();
  })
}




export { showList }
