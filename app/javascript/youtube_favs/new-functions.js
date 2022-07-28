let newVideoAddButton = document.getElementById("new-btn")
let messagesElement = document.getElementById("new-video-messages")
let validLinkColor = "green"
let invalidLinkColor = "red"

// Checks typed link and enables `Add` button in case it is valid.
export function checkLink(event) {
    let link = event.target.value
    let linkStart = link.substring(0,8)
    let youtubeVideoId = link.split("watch?v=")[1]
    let linkIsValid = linkStart === "https://" && youtubeVideoId != null && youtubeVideoId.length > 4

    if(linkIsValid){
        setValidLinkStatus(newVideoAddButton,messagesElement)
    } else {
        setInvalidLinkStatus(newVideoAddButton, messagesElement, link)
    }
}

// Enables the `Add Button` and set a valid link message above the new video input.
let setValidLinkStatus = (addButton, messagesElement) => {
    addButton.removeAttribute("disabled")
    messagesElement.textContent = "valid link"
    messagesElement.style.color = validLinkColor
    messagesElement.style.opacity = "1"
}

// Disables the `Add Button` and set an invalid link message above the new video input.
let setInvalidLinkStatus = (addButton, messagesElement, link) => {
    let linkIsEmpty = link.length === 0

    if(linkIsEmpty){
        messagesElement.style.opacity = "0"
    } else {
        messagesElement.textContent = "invalid link"
        messagesElement.style.opacity = "1"
    }

    addButton.setAttribute("disabled","disabled")
    messagesElement.style.color = invalidLinkColor
}
