import { Controller } from "stimulus"
import { csrfToken } from '@rails/ujs'

export default class extends Controller {
  static targets = [ "namelistnew" ]

  connect() {
   console.log("List connected");
  }

  // handleClickFunction = (e) => {
  //   const restName = e.currentTarget.dataset.restaurantName;
  //   alert(`${restName} added!`);
  // }

  createNewList = (e) => {
    e.preventDefault()
    // get the name of the list
    const listTitle = this.namelistnewTarget.value

    // get the items in localstorage
    const restsArr = window.localStorage.list
    const userIdNum = restsArr[0].userId;
    // console.log(userIdNum);

    // call fetch(`/users/:user_id/lists/new`)
    fetch(`/users/${userIdNum}/lists`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/html',
        "X-CSRF-Token": csrfToken()
      },
      body: JSON.stringify({listTitle, restsArr}),
    })
    .then(response => response.text())
    .then( html => document.body.innerHTML = html )
    console.log(html)
    }


    // can we update another target?
    // list?
}
