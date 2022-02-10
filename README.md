# ScriptLib

Early and in progress scripting suite for Swift apps.

The goal is to create an API like AppleScript's standard suite, except implement using an embedded JavaScriptCore context. Manny macOS apps use this approach, but it looks like everyone is building there own solution. (Please let me know if there are open source solutions that I've missed). Here are some apps and related JavaScript API's to be inspired by:

- [Drafts](https://docs.getdrafts.com/docs/actions/scripting)
- [Noteplan](https://help.noteplan.co/article/65-commandbar-plugins)
- [Nova](https://docs.nova.app)
- [Omni Automation](https://omni-automation.com/)
- [Paw](https://paw.cloud/docs/reference/ExtensionContext)
- [Proxyman](https://docs.proxyman.io/scripting/script)
- [Scriptable](https://docs.scriptable.app)
- [Sketch](https://developer.sketch.com/reference/api/)
- [TaskPaper](https://www.taskpaper.com/guide/reference/scripting/)

To try out what's here:

1. Open and run the Example app.

2. Type `app.version` in the apps window an press Return. You should see `1.0`.

2. Enter `app.beep()`. It should beep!

3. Enter `app.documents[0].fileURL`. You should see "undefined" if you haven't yet saved, or a URL object if you have saved.

4. Enter `app.documents[0].text`. You should see "Hello World".

5. Enter `app.documents[0].text = "Hello, Hello World". You have assigned a new text value to the document.

That's about it! :)

But there are a number of basic design decision made.

1. ScriptLib provides some behavior for free. For example the demo app didn't have to implement `app.version`, `app.documents`, `app.windows`, etc.

2. ScriptLib makes it possible to extend this default scripting support. For example `document.text` is a custom property added by the demo app.

Generally scripting support is added by:

1. Wrapping "Swift" objects inside a "JS" wrapper object. (Generally the "JS" object should weakly hold big reference types such as windows and documents so scripts don't create leaks).

2. The scripting API is then exposed on that wrapper object by implementing protocol rooted at `JSExport`.

## Todos

- Implement features from AppleScript Standard Suite, combined with whatever useful standards can be understood by looking at existing app scripting APIs.

- Add features for interacting with user. For example `showAlert`, `getInput`, `chooseFromList`, etc. These features consist of define JavaScript API and then native Swift implementation.

- Add support for plugins. Generally plugins are just scripts that are automatically loaded and run.

    - Define plugin format
    - API to find plugins in common locations
    - API to load those plugins into a ScriptContext and call lifecycle events
    - API to allow plugins to subscribe to events such as documents and windows opening and closing. 

- Figure out some sane way to generate documentation. Ideally each `JSExport` protocol can be documented in Swift and then a script can extract that documentation and export in form suitable for JavaScript development.

## Notes

- There is mention in the code of iOS support. This would be nice eventually, but goal right now is just macOS.

- This is all in exploratory phase. Maybe better way to do things. Let me know!
