// Entry point for the build script in your package.json
import * as bootstrap from "bootstrap"
import {
  appendCopyButtonToCodeBlocks,
  copyDivToClipboard
} from "./copy.js"

window.addEventListener('load', function () {
  appendCopyButtonToCodeBlocks();
});
