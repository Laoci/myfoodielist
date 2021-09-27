import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "namelistnew" ]

  connect() {
   console.log("List connected");
  }

  handleClickFunction = (e) => {
    alert("Click function");
  }

  createNewList = (e) => {
    e.preventDefault()
    // get the name of the list
    const listTitle = this.namelistnewTarget.value

    // get the items in localstorage
    const restsArr = JSON.parse(window.localStorage.list)
    const userIdNum = restsArr[0].userId;
    // console.log(userIdNum);

    // call fetch(`/users/:user_id/lists/new`)
    fetch(`/users/${userIdNum}/lists/new`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    })
    .then(response => response.json())
    .then(data => {
      console.log(data);
    })


    // can we update another target?
    // list?
  }
}
