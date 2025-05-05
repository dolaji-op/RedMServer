CONFIG = {
    image: {
        active: false, // If you want an image background make this flag true (but make sure youtube/video is false)
        // source: "url('nui://loadscreen/ui/assets/rdrloading.png')",
        // source: 'url(https://media.discordapp.net/attachments/932109362623832146/1157670029291167856/rdrloading.png)',
        // backgroundcolor: "#ffffff", // Background color if no image is specified
    },
    video: {
        active: true, //If you want a local video make this flag true (but make sure image/youtube is false)
        source: "nui://loadscreen/ui/assets/loading_screen.webm",
        looped: true, // If the video is not looped then the loadscreen will "close" when the video ends. otherwise it will loop until the loading is actually done.
        mute: true,
        volume: 0.5, //between 0-1
    },
    youtube: {
        active: false, //If you want a youtube video make this flag true (but make sure image/video is false)
        source: "4KPpWQ7XVO8",
        looped: false, // If the video is not looped then the loadscreen will "close" when the video ends. otherwise it will loop until the loading is actually done.
        mute: false,
        volume: 50 // 0 - 100
    },
    googledrive: {
        active: false, //If you want a youtube video make this flag true (but make sure image/video is false)
        source: "<YOUR VIDEO ID>", //ID of your google drive video. 1: Make the video shared with anyone with the link, then copy the link Example: https://drive.google.com/file/d/<YOUR VIDEO ID>/view
        looped: false, // If the video is not looped then the loadscreen will "close" when the video ends. otherwise it will loop until the loading is actually done.
        mute: false,
        volume: 0.5, //between 0-1
    },
    audio: {
        active: false,
        source: 'nui://loadscreen/ui/assets/music.mp3',
        volume: 0.5, //between 0-1
    },
    loadtime: {
        skip: true, //Skip will only occur after the main game has loaded (this cannot be skipped)
        lang: "Press Space to Skip Load Screen"
    },
    timeelapsed: true,
    loading: {
        active: true, //Do you want the loading icon to show
        icon: "wheel", // Options: https://github.com/BryceCanyonCounty/loadscreen/wiki/Loading-Spinner-Options
        color: "#ffff"
    }
}