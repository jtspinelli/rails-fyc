import {checkLink} from "./new-functions"

let newVideoInput = document.getElementById("new-input")

let inputEvents = ["keyup", "paste"]

inputEvents.forEach((eventName) => {
    newVideoInput.addEventListener(eventName, (event) => {
        setTimeout(() => {
            checkLink(event)
        })
    })
})