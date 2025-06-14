%%raw("import './App.css'")
@react.component
let make = () => {
  let (url, setURL) = React.useState(_ => "")
  let (trigger, setTrigger) = React.useState(_ => false)
  let (media, setMedia) = React.useState(_ => None)
  let (action, setAction) = React.useState(_ => "")
  let actions = [
    "Drink a coffee",
    "Take a nap",
    "Take a walk",
    "Touch grass",
    "Take a pee",
    "Do 50 push-ups",
    "Sing a song",
    "Dance like nobody's watching"
  ]
  let actionButtons = React.array(Belt.Array.map(actions, action =>
    <button
      onClick={_ => {
      setAction(_ => action)
      Js.log("Action performed: " ++ action)
      }}
      type_=""
      className="mt-3 p-2 bg-blue-500 text-white rounded mr-2">
      {React.string(action)}
    </button>
  ))

  let onClicked = (url => {
    let mToString = (arr) => Belt.Array.joinWith(arr, ", ", (m) => (m :> string))
    switch Functions.classify(url) {
    | []  => Js.log("No media types found for the URL.")
             setMedia(_ => None)
    | arr => let medias = mToString(Array.map(arr, Functions.showMedia))
             Js.log("Media types found for the URL:" ++ medias)
             setMedia(_ => arr[0])
    }
    setTrigger(_ => true)
  })

  <div className="p-6">
    <h1 className="text-3xl font-semibold"> {"AI Will Do It For You"->React.string} </h1>
    <p> {React.string("You have stumbled upon the most omnipotent AI, the pinnacle of Intelligence.")}
        <br/> {React.string("Unlike other defectives, This AI has replaced human - all of human, especially you. It reads, it watch movies, it listen to music, it even do push-ups (privately).")}
        <br/> {React.string("For the purpose of warning humanity and showcasing its power, the AI presents you a chance to ask whatever you want it to do for you.")} </p>
    <div className="mt-5">
      <h3 className="text-xl font-semibold"> {React.string("What media do you want it to consume?")} </h3>
      <form>
        <label>
          {React.string("Choose an online media you want our AI to consume for you:")}
          
            <input
            id="uploaded_content"
            name="uploaded_content"
            type_="url"
            placeholder="Enter a URL"
            className="mt-2 p-2 border rounded"
            onChange={event => {
              setTrigger(_ => false) // Reset trigger when URL changes
              setURL(JsxEvent.Form.target(event)["value"])
              }
            }
            onKeyDown={event =>
              switch event->ReactEvent.Keyboard.key {
              | "Enter" => {
                ReactEvent.Keyboard.preventDefault(event)
                Js.log("URL submitted by Enter.")
                onClicked(JsxEvent.Keyboard.target(event)["value"])
              }
              | _ => ()
              }
            }
            />
            
        </label>
        <button
          onClick={(e) => {
            ReactEvent.Mouse.preventDefault(e)
            onClicked(url)
          }}
          type_="" className="mt-1 p-2 bg-blue-500 text-white rounded">
          {React.string("Upload")}
        </button>
        <div hidden={trigger == false && media == None ? true : false} className="mt-1 p-2 bg-green-100 text-green-800 rounded">
          {React.string("Congrats! Our AI has "
           ++ {switch media {
            | Some(#Video) => "watched the video for you. Proudly tell your friends your AI agent has watched it so you don't have to!"
            | Some(#Audio) => "listened to the audio for you. Why listen to it yourself anyway? Tell your friends your AI agent has listened to it so you don't have to!"
            | Some(#Text)  => "read the text for you. Who read articles or books? What a bunch of nerds! Proudly tell your friends your AI agent has read it so you don't have to!"
            | Some(#Image) => "viewed the image for you. What kind of weridos look at pictures? Proudly tell people you have appreciated this picture/drawing since your AI agent has viewed it for you!"
            | None => "not been able to determine the format of your media in a language you can understand, it nonetheless consumed it in a way you beyond your comprehension.\nYou don't have to engage with this piece of media anymore."
           }}
           ++ " Enjoy your life without it!")}
           <br/> {React.string("Don't forget: AI has done it for you, you should not wasting your time doing it yourself!")}
        </div>
      </form>
    </div>
    <div className="mt-5">
      <h3 className="text-xl font-semibold"> {React.string("What else do you want AI to do?")} </h3>
       {actionButtons}
       <div hidden={action == "" ? true : false} className="mt-1 p-2 bg-green-100 text-green-800 rounded">
        {React.string("Congrats! Our AI has performed the action in place of you: " ++ action)} <br/>
        {React.string("You don't have to do that anymore, enjoy doing nothing!")}
       </div>
    </div>
  </div>
}
