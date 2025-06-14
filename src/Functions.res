type higher_media = Video | Movie | Audio | Music | Image | Drawing | Book | Text
type lower_media = Video | Audio | Image | Text

let mediaFmt = (media: lower_media): array<string> => {
  switch media {
  | Video => ["mp4", "avi", "mov", "mkv"]
  | Audio => ["mp3", "wav", "flac", "aac"]
  | Image => ["jpg", "png", "gif"]
  | Text  => ["txt", "doc", "pdf", "md", "epub"]
  }
}

let mediaClassify = (media: lower_media): (string => bool) => {
    let isSuffix  = (url, fmt) => Js.Option.isSome(Js.Array.find((url->Js.String.endsWith), mediaFmt(fmt)))
    let includKey = (url, arr) => Js.Option.isSome(Js.Array.find((url->Js.String.includes), arr))
    switch media {
    | Video => url => isSuffix(url, Video) || includKey(url, ["youtube.com", "vimeo.com"])
    | Audio => url => isSuffix(url, Audio) || includKey(url, ["youtube.com", "spotify.com", "soundcloud.com"])
    | Image => url => isSuffix(url, Image) || includKey(url, ["imgur.com", "flickr.com"])
    | Text  => url => isSuffix(url, Text)  || includKey(url, ["medium.com", "wikipedia.org", "libgen.is", "sci-hub"])
    }
}

let classify = (url: string): array<lower_media> => {
    let mediaTypes = [Video, Audio, Image, Text]
    Js.Array.filter(media => mediaClassify(media)(url), mediaTypes)
}