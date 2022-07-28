// Opens the options menu and mark the respective video container with attribute "options-opened"
export function openOptionsMenu(videoContainer, optionsList) {
    optionsList.style.display = "block"
    videoContainer.setAttribute("options-opened", "")
}

// Closes the options menu and remove attribute "options-opened" from the respective video container
export function closeOptionsMenu(videoContainer, optionsList) {
    optionsList.style.display = "none"
    videoContainer.removeAttribute("options-opened")
}

// Fill the delete confirmation model with clicked video info (thumb, title and id)
export function fillConfirmationModal(e) {
    let clickedVideoId = e.target.attributes["video-id"].value
    let videoAttributes = Array.from(document.getElementsByClassName("video-container")).filter(e => e.attributes["video-id"].value === clickedVideoId)[0].attributes

    let videoTitle = document.getElementById("video-info-title")
    let videoThumb = document.getElementById("video-info-thumb")
    let videoId = document.getElementById("video-info-id")

    videoTitle.textContent = videoAttributes["title"].value
    videoThumb.setAttribute("src", videoAttributes["thumb-url"].value)
    videoId.value = clickedVideoId
}

// Opens the delete confirmation model
export function toggleConfirmationModal(modal) {
    modal.classList.toggle("hidden")
}