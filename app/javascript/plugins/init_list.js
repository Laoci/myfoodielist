const handleClickFunction = (event) => {
  const restId = event.currentTarget.dataset.restaurantId;
  const restName = event.currentTarget.dataset.restaurantName;
  const userId = event.currentTarget.dataset.userId;
  addToLocalStorage(restId, restName, userId);
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
const addToLocalStorage = (restId, restName, userId) => {
  // local store not empty - start the list
  if (window.localStorage.list) {
    // console.log("exist");
    const restaurantsArray = JSON.parse(window.localStorage.list);

    if (!restObjExists(restaurantsArray, restId)) {
      restaurantsArray.push({
        restId: restId,
        restName: restName,
        userId: userId
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
        restName: restName,
        userId: userId
      }
    ]))
  }
}

export { initList };
