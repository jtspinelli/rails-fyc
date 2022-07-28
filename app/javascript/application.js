setTimeout(() => {
    let flash = document.getElementById("flash-notice")
    if(flash){
        flash.classList.remove("notice-show")
    }
}, 3000)

// Import `New` javascript file if input for new video is on actual page
if(document.getElementById("new-input")) {
    import("./youtube_favs/new")
}

// Import `Video container` javascript file if Video Container elements are on actual page
if(document.getElementsByClassName("video-container").length > 0) {
    import("./youtube_favs/container-options")
}