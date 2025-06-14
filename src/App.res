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
    "Touch grass"
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
    Js.log("Triggered!")
  })

  <div className="p-6">
    <h1 className="text-3xl font-semibold"> {"AI Will Do It For You"->React.string} </h1>
    <p> {React.string("Our AI the pinnacle of Intelligence.\nIt replace what a human does -\nit reads, it watch movies, it listen to music.")} </p>
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
            onChange={event =>
              setURL(JsxEvent.Form.target(event)["value"])
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
          {url != "" ? React.string("Congrats! Our AI has "
                                    ++ {switch media {
                                     | Some(#Video) => "watched the video for you. Why watch a video or a movie when you can watch an AI-dubbed 1 minute cut on Youtube or TikTok? Why watch those slops when AI can watch it for you? Proudly tell people your AI agent has watched it so you don't have to!"
                                     | Some(#Audio) => "listened to the audio for you. Why listen to it yourself anyway? Tell people your AI agent has listened to it so you don't have to!"
                                     | Some(#Text)  => "read the text for you. Who read articles nowadays? Or even worse...books! What a bunch of nerds! Proudly tell people your AI agent has read it so you don't have to!"
                                     | Some(#Image) => "viewed the image for you. What kind of werido look at pictures? It's probably AI-generated anyways. Proudly tell people you have appreciated this picture/drawing since your AI agent has viewed it for you!"
                                     | None => "not been able to describe the format of your chosen media in a language you can understand. But fear not! With its superintellgence beyound human comprehension, Our AI has nonetheless consumed it in a way you cannot even fathom.\nYou don't have to engage with this piece of media anymore."
                                    }}
                                    ++ " Enjoy your life without it!")
                                    : React.string("Please enter a URL to upload media.")}
        </div>
//         <div hidden={trigger == false || media != None ? true : false} className="mt-1 p-2 bg-green-100 text-green-800 rounded">
//           {React.string("Our AI cannot describe the format of your chosen media in a language you can understand. But fear not! With its superintellgence beyound human comprehension, Our AI has nonetheless consumed it in a way you cannot even fathom.\nYou don't have to engage with this piece of media anymore."
// )}
//         </div>
      </form>
    </div>
    <div className="mt-5">
      <h3 className="text-xl font-semibold"> {React.string("What else do you want it to do?")} </h3>
       {actionButtons}
       <div hidden={action == "" ? true : false} className="mt-1 p-2 bg-green-100 text-green-800 rounded">
        {React.string("Congrats! Our AI has performed the action in place of you: " ++ action)} <br/>
        {React.string("You don't have to do that anymore, enjoy doing nothing!")}
       </div>
    </div>
  </div>
}
