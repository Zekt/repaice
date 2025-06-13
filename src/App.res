%%raw("import './App.css'")
@react.component
let make = () => {
  let (count, setCount) = React.useState(() => 0)

  <div className="p-6">
    <h1 className="text-3xl font-semibold"> {"AI Will Do It For You"->React.string} </h1>
    <p> {React.string("Our AI the pinnacle of Intelligence.\nIt replace what a human does -\nit reads, it watch movies, it listen to music.")} </p>
    <div className="mt-5">
      <h3 className="text-xl font-semibold"> {React.string("What media do you want it to consume?")} </h3>
      <form>
        <label>
          {React.string("Choose a media you want the AI to comsume:")}
          
            <input
            name="uploaded_content"
            type_="url"
            placeholder="Enter a URL"
            className="mt-2 p-2 border rounded"
            onKeyDown={event =>
              switch event->ReactEvent.Keyboard.key {
              | "Enter" => {
                ReactEvent.Keyboard.preventDefault(event)
                Js.log("URL submitted by Enter.")
                setCount(count => count + 1)
              }
              | _ => ()
              }
            }
            />
            
        </label>
        <button onClick=(_ =>setCount(count => count + 1)) type_="" className="mt-3 p-2 bg-blue-500 text-white rounded">
          {React.string("Upload")}
        </button>
        {React.string(`count is ${count->Int.toString}`)}
      </form>
    </div>
  </div>
}
