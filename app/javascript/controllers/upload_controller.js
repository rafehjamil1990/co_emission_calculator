// app/javascript/controllers/upload_controller.js

import { Controller } from "@hotwired/stimulus";
import { DirectUpload } from "@rails/activestorage";

export default class extends Controller {
  static targets = ["input", "progressIcon", "form"];

  connect() {
    console.log("hello world 1");
  }

  uploadFile() {
    Array.from(this.inputTarget.files).forEach((file) => {
      const upload = new DirectUpload(
        file,
        this.inputTarget.dataset.directUploadUrl,
        this
      );

      upload.create((error, blob) => {
        if (error) {
          console.log(error);
        } else {
          this.createHiddenBlobInput(blob);
          this.progressIconTarget.classList.remove(
            "bi-x-circle",
            "text-danger"
          );
          this.progressIconTarget.classList.add(
            "bi-check-circle",
            "text-success"
          );
        }
      });
    });
  }

  createHiddenBlobInput(blob) {
    const hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("value", blob.signed_id);
    hiddenField.name = this.inputTarget.name;
    this.formTarget.appendChild(hiddenField);

    fetch(this.formTarget.action, {
      method: "POST",
      headers: {
        Accept: "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']")
          .content,
      },
      body: new FormData(this.formTarget),
    });
  }

  directUploadWillStoreFileWithXHR(request) {
    request.upload.addEventListener("progress", (event) => {
      this.progressUpdate(event);
    });
  }

  progressUpdate(event) {
    const progress = (event.loaded / event.total) * 100;
    console.log("progress: " + progress);
    // this.progressTarget.innerHTML = progress;
  }
}
