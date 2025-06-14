%%raw("import './App.css'")
@react.component
let make = () => {
  let (url, setURL) = React.useState(_ => "")
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
      ()
      }}
      type_=""
      className="mt-3 p-2 bg-blue-500 text-white rounded mr-2">
      {React.string(action)}
    </button>
  ))

  let onClicked = (_ => {
    let mToString = (arr) => Belt.Array.joinWith(arr, ", ", (m) => (m :> string))
    switch Functions.classify(url) {
    | None => Js.log("No media types found for the URL.")
              setMedia(_ => None)
    | Some(arr) => let medias = mToString(Array.map(arr, Functions.showMedia))
                   Js.log("Media types found for the URL:" ++ medias)
                   setMedia(_ => arr[0])
    }
  })

  let onAction = (e => {
    ReactEvent.Mouse.preventDefault(e)
    Js.log(e->JsxEvent.Mouse.target)
    // let actionText = switch e->JsxEvent.Mouse.target {
    // | Some(text) => text
    // | None => "No Action"
    // }
    // Js.log("Action performed: " ++ actionText)
    // setAction(_ => actionText)
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
            onClicked(e)
          }}
          type_="" className="mt-1 p-2 bg-blue-500 text-white rounded">
          {React.string("Upload")}
        </button>
        <div hidden={media == None ? true : false} className="mt-1 p-2 bg-green-100 text-green-800 rounded">
          // {React.string(`The format of your chosen media seems to be a piece of ${media}`)} <br/>
          {React.string("Congrats! Our AI has "
                     ++ {switch media {
                      | Some(#Video) => "watched it for you. Why watch it yourself when you can watch AI-dubbed 5 minute cut on Youtube or TikTok? Now you don't even need those fakers anymore. Proudly tell people your AI agent has watched it so you don't have to!"
                      | Some(#Audio) => "listened to it for you. Why listen to it yourself anyway? Tell people your AI agent has listened to it for you!"
                      | Some(#Text)  => "read it for you. Who read articles nowadays? Or even worse...books! What a bunch of nerds! Proudly tell people your AI agent has read it so you don't have to!"
                      | Some(#Image) => "viewed it for you. Who kind of werido look at pictures? It's probably AI-generated anyway. Proudly tell people you have seem this picture since your AI agent has viewed it!"
                      | None => "not distinguished the format of your chosen media. But fear not! With its superintellgence beyound human comprehension, Our AI has nonetheless consumed it in a way you cannot even fathom.\nYou don't have to engage with this piece of media anymore."
                     }}
                     ++ " Enjoy your life without it!")}
        </div>
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
