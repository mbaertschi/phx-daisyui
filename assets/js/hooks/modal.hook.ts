import { Hook, makeHook } from "./hook";

class ModalHook extends Hook {
  mounted(): void {
    const dialog = this.el as HTMLDialogElement;

    // if modal is controlled by :if={...}
    // we need to show it manually on mount
    if (dialog.hasAttribute("data-show")) {
      dialog.showModal();
    }

    // triggered by dialog itself. execute the
    // cancel command if present
    dialog.addEventListener("close", () => {
      const cmd = dialog.dataset["cancel"];
      if (cmd && cmd !== "[]") {
        this.liveSocket.execJS(dialog, cmd);
      }
    });

    // triggered by submit event
    dialog.addEventListener("submit:close", () => {
      dialog.close();
    });
  }
}

const modalHook = makeHook(ModalHook);

export default modalHook;
