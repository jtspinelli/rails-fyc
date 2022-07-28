import {
    openOptionsMenu,
    closeOptionsMenu,
    fillConfirmationModal,
    toggleConfirmationModal
} from './modal-functions'

let videoContainers = document.getElementsByClassName("video-container")
let options = document.getElementsByClassName("options")
let optionsButtons = document.getElementsByClassName("options-btn")
let optionsLists = document.getElementsByClassName("options-list")
let deleteConfirmationModal = document.getElementById("delete_confirmation_modal")
let deleteConfirmationModalBackground = document.getElementById("modal-background")
let deleteConfirmationModalCancelBtn = document.getElementById("modal-btn-cancel")

for(let i = 0; i < options.length; i++){
    let videoContainer = videoContainers[i]
    let optionsButton = optionsButtons[i]
    let optionsList = optionsLists[i]

    optionsButton.addEventListener("click", (e) => {
        e.preventDefault()
        openOptionsMenu(videoContainers[i], optionsList)
    })

    let elements = [videoContainer, optionsList]
    elements.forEach((el) => {
        el.addEventListener("mouseleave", () => {
            closeOptionsMenu(videoContainer, optionsList)
        })
    })

    optionsList.addEventListener("click", (e) => {
        e.preventDefault()
        closeOptionsMenu(videoContainer, optionsList)
        fillConfirmationModal(e)
        toggleConfirmationModal(deleteConfirmationModal)
    })
}

let elements = [deleteConfirmationModalCancelBtn, deleteConfirmationModalBackground]
elements.forEach((el) => {
    el.addEventListener("click", () => {
        toggleConfirmationModal(deleteConfirmationModal)
    })
})