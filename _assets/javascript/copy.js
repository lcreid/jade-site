export function copyDivToClipboard(event) {
  text = event.target.previousElementSibling.innerText;
  navigator.clipboard.writeText(text);
}

export function appendCopyButtonToCodeBlocks() {
  // get the list of all highlight code blocks
  const highlights = document.querySelectorAll("div.highlight");

  highlights.forEach(div => {
    // create the copy button
    const copy = document.createElement("button");
    copy.classList.add("copy-button", "btn", "btn-outline-primary", "btn-sm");
    copy.innerHTML = "Copy";
    // add the event listener to each click
    copy.addEventListener("click", copyDivToClipboard);
    // append the copy button to each code block
    div.append(copy);
  });
}
