type lower_media = [ #Video | #Audio | #Image | #Text ]
type higher_media = [ lower_media | #Movie | #Music | #Drawing | #Book ]

let showMedia = (media): string => {
  switch media {
  | #Video => "Video"
  | #Audio => "Audio"
  | #Image => "Image"
  | #Text  => "Text"
  | #Movie => "Movie"
  | #Music => "Music"
  | #Drawing => "Drawing"
  | #Book => "Book"
  }
}

let mediaFmt = (media: lower_media): array<string> => {
  switch media {
  | #Video => ["mp4", "avi", "mov", "mkv"]
  | #Audio => ["mp3", "wav", "flac", "aac"]
  | #Image => ["jpg", "png", "gif"]
  | #Text  => ["txt", "doc", "pdf", "md", "epub"]
  }
}

let mediaClassify = (media: lower_media, url: string): bool => {
    if url != "" {
      let isSuffix  = (url, fmt) => Js.Array.some((url->Js.String.endsWith), mediaFmt(fmt))
      let includKey = (url, arr) => Js.Array.some((i) => i == true, arr->Array.map((key) => Js.String.includes(url, key)))
      // let includKey = (url, arr) => Js.Option.isSome(Js.Array.find((url->Js.String.includes), arr))
      switch media {
      | #Video => isSuffix(url, #Video) || includKey(url, ["youtube.com", "vimeo.com"])
      | #Audio => isSuffix(url, #Audio) || includKey(url, ["spotify.com", "soundcloud.com"])
      | #Image => isSuffix(url, #Image) || includKey(url, ["imgur.com", "flickr.com"])
      | #Text  => isSuffix(url, #Text)  || includKey(url, ["medium.com", "wikipedia.org", "libgen.is", "sci-hub"])
      }
    } else {
      false
    }
}

let classify = (url: string): array<lower_media> => {
    let mediaTypes = [#Video, #Audio, #Image, #Text]
    mediaTypes->Array.filter((media) => mediaClassify(media, url))
}