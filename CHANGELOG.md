# 0.1.0

This is the first major release to go live and features the following changes:

- **Bootstrap** - When the SDK is included on a page featuring one or more widget tags (identified by the `ct-widget` **class**), it will convert the tags into iframes representing the configured functionality, such as a list of rewards or a survey. This process kicks off when the DOM is fully loaded.

- **Widget** - Handles communications between the host page and the iframe, ensuring dynamic resizing of height as well as visibility on the page. A widget can currently raise 2 events that affect the user experience on the host page:
  - `modal:open` - Opens a modal on the host page.
  - `navigate` - Opens a new tab / popup to an external url.

- **Modal** - 2 elements will be inserted into the host page for proper rendering of modals:
  - `<div id="ct-modal">` - The container responsible for rendering the actual widget.
  - `<div id="ct-modal-background">` - For a disabled, dimmed background.

- **Event** - By using `CT.Event.subscribe()`, the host page can listen on various events raised by widgets, responding to actions like a user logging in.

_Additional:_

- Verbose debugging in the console can be turned on by setting the global `CT_DEBUG` JavaScript property to `true`.
- If lacking the responsive `<meta>` viewport tag, host page will have one set automatically when displaying a modal for optimal rendering on mobile devices.