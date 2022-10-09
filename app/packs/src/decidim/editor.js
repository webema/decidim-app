/* eslint-disable require-jsdoc */

import lineBreakButtonHandler from "src/decidim/editor/linebreak_module"
import "src/decidim/vendor/image-resize.min"
import "src/decidim/vendor/image-upload.min"

import htmlEditButton from "quill-html-edit-button";

// START fix links with missing protocol

const Link = Quill.import('formats/link');

// Override the existing property on the Quill global object and add custom protocols
Link.PROTOCOL_WHITELIST = ['http', 'https', 'mailto'];

class CustomLinkSanitizer extends Link {
  static sanitize(url) {
  // Run default sanitize method from Quill
  const sanitizedUrl = super.sanitize(url);

  // Not whitelisted URL based on protocol so, let's return `blank`
  if (!sanitizedUrl || sanitizedUrl === 'about:blank') return sanitizedUrl;

  // Verify if the URL already have a whitelisted protocol
  const hasWhitelistedProtocol = this.PROTOCOL_WHITELIST.some(function(protocol) {
      return sanitizedUrl.startsWith(protocol);
  });

  if (hasWhitelistedProtocol) return sanitizedUrl;

  // if not, then append only 'https' to not to be a relative URL
  return `https://${sanitizedUrl}`;
  }
}

Quill.register(CustomLinkSanitizer, true)

// END fix links with missing protocol

Quill.register({
  "modules/htmlEditButton": htmlEditButton
})

const quillFormats = ["bold", "italic", "link", "underline", "header", "list", "video", "image", "alt", "break", "width", "style", "code", "blockquote", "indent"];

export default function createQuillEditor(container) {
  const toolbar = $(container).data("toolbar");
  const disabled = $(container).data("disabled");

  let quillToolbar = [
    ["bold", "italic", "underline", "linebreak"],
    [{ list: "ordered" }, { list: "bullet" }],
    ["link", "clean"],
    ["code", "blockquote"],
    [{ "indent": "-1"}, { "indent": "+1" }]
  ];

  let addImage = $(container).data("editorImages");

  if (toolbar === "full") {
    quillToolbar = [
      [{ header: [2, 3, 4, 5, 6, false] }],
      ...quillToolbar,
      ["video"]
    ];
  } else if (toolbar === "basic") {
    quillToolbar = [
      ...quillToolbar,
      ["video"]
    ];
  }

  if (addImage) {
    quillToolbar.push(["image"]);
  }

  let modules = {
    linebreak: {},
    toolbar: {
      container: quillToolbar,
      handlers: {
        "linebreak": lineBreakButtonHandler
      }
    },
    htmlEditButton: {}
  };
  const $input = $(container).siblings('input[type="hidden"]');
  container.innerHTML = $input.val() || "";
  const token = $('meta[name="csrf-token"]').attr("content");
  if (addImage) {
    modules.imageResize = {
      modules: ["Resize", "DisplaySize"]
    }
    modules.imageUpload = {
      url: $(container).data("uploadImagesPath"),
      method: "POST",
      name: "image",
      withCredentials: false,
      headers: { "X-CSRF-Token": token },
      callbackOK: (serverResponse, next) => {
        $("div.ql-toolbar").last().removeClass("editor-loading")
        next(serverResponse.url);
      },
      callbackKO: (serverError) => {
        $("div.ql-toolbar").last().removeClass("editor-loading")
        console.log(`Image upload error: ${serverError.message}`);
      },
      checkBeforeSend: (file, next) => {
        $("div.ql-toolbar").last().addClass("editor-loading")
        next(file);
      }
    }
  }
  const quill = new Quill(container, {
    modules: modules,
    formats: quillFormats,
    theme: "snow"
  });

  if (disabled) {
    quill.disable();
  }

  quill.on("text-change", () => {
    const text = quill.getText();

    // Triggers CustomEvent with the cursor position
    // It is required in input_mentions.js
    let event = new CustomEvent("quill-position", {
      detail: quill.getSelection()
    });
    container.dispatchEvent(event);

    if (text === "\n" || text === "\n\n") {
      $input.val("");
    } else {
      $input.val(quill.root.innerHTML);
    }
  });
  // After editor is ready, linebreak_module deletes two extraneous new lines
  quill.emitter.emit("editor-ready");

  if (addImage) {
    const text = $(container).data("dragAndDropHelpText");
    $(container).after(`<p class="help-text" style="margin-top:-1.5rem;">${text}</p>`);
  }

  // After editor is ready, linebreak_module deletes two extraneous new lines
  quill.emitter.emit("editor-ready");

  return quill;
}
