const handleClickFunction = (event) => {
  const restId = event.currentTarget.dataset.restaurantId;
  const restName = event.currentTarget.dataset.restaurantName;
  addToLocalStorage(restId, restName);
  location.reload();
}

const initList = () => {
  // when click on add button
  const addToListBtns = document.querySelectorAll('.add-to-list')
  const listBtn = addToListBtns.forEach((btn) => {
    btn.addEventListener('click', handleClickFunction);
  })
}

const restObjExists = (restaurantsArray, givenId) => {
  return restaurantsArray.find((restaurantObj) => restaurantObj.restId === givenId);
}


// to do next: addToLocalStorage function
const addToLocalStorage = (restId, restName) => {
  // local store not empty - start the list
  if (window.localStorage.list) {
    // console.log("exist");
    const restaurantsArray = JSON.parse(window.localStorage.list);

    if (!restObjExists(restaurantsArray, restId)) {
      restaurantsArray.push({
        restId: restId,
        restName: restName
      })
      window.localStorage.setItem('list', JSON.stringify(restaurantsArray))
    } else {
      // console.log('do nothing');
    }
  } else {
    // console.log("not exist");
    window.localStorage.setItem('list', JSON.stringify([
      {
        restId: restId,
        restName: restName
      }
    ]))
  }
}

export { initList };
