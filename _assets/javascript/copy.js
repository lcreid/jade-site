export function copyDivToClipboard(event) {
  text = event.currentTarget.previousElementSibling.innerText;
  navigator.clipboard.writeText(text);
}

export function appendCopyButtonToCodeBlocks() {
  // get the list of all highlight code blocks
  const highlights = document.querySelectorAll("div.highlight");

  highlights.forEach(div => {
    // create the copy button
    const copy = document.createElement("button");
    copy.classList.add("copy-button", "btn", "btn-outline-primary", "btn-sm");
    copy.innerHTML = '<svg viewBox="0 0 16 16" height="1rem" width="1rem"><use href="#copy-button-svg" /></svg>';
    // add the event listener to each click
    copy.addEventListener("click", copyDivToClipboard);
    // append the copy button to each code block
    div.append(copy);
  });
}
