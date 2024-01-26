import { Hook, makeHook } from "./hook";

// https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#link/1-overriding-the-default-confirm-behaviour
class AlertHook extends Hook {
  mounted(): void {
    const alert = this.el as HTMLDialogElement;
    if (!alert) return;

    // store the command to be executed on confirm
    let cmd: string | null = null;

    alert.addEventListener("close", (e) => {
      if (alert.returnValue === "confirm") {
        const cmdOrConfirm = cmd || alert.dataset["confirm"];
        if (cmdOrConfirm) {
          try {
            if (cmdOrConfirm) {
              this.liveSocket.execJS(this.el, cmdOrConfirm);
            }
          } catch (e) {
            console.error(e);
          } finally {
            cmd = null;
          }
        }
      } else {
        cmd = null;
        const cancelCmd = alert.dataset["cancel"];
        if (cancelCmd) {
          try {
            this.liveSocket.execJS(this.el, cancelCmd);
          } catch (error) {
            console.error(error);
          }
        }
      }
    });

    // listen on document.body, so it's executed before the default of
    // phoenix_html, which is listening on the window object
    document.body.addEventListener(
      "phoenix.link.click",
      function (e) {
        // Prevent default implementation
        e.stopPropagation();

        // Introduce alternative implementation
        const message = (e.target as HTMLElement).getAttribute("data-confirm");
        if (!message) return;

        // store the command to be executed on confirm
        const phxEvent = (e.target as HTMLButtonElement).getAttribute(
          "phx-click"
        );
        if (!phxEvent) return;
        cmd = phxEvent;

        // if message and command are present, show the dialog
        // and prevent the default behaviour
        e.preventDefault();
        alert.showModal();
      },
      false
    );
  }
}

const alertHook = makeHook(AlertHook);

export default alertHook;
