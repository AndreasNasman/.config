await main();

async function main() {
  const directoryHandle = await window.showDirectoryPicker({
    startIn: "documents",
  });
  const ids = await findYouTubeIds(directoryHandle);
  const { size: count } = ids;
  console.log(
    `🔍 Found ${count} referenced YouTube video${count == 1 ? "" : "s"}`,
  );
  if (count == 0) {
    return;
  }

  let highlightedVideos = 0;
  for (const id of ids) {
    const element = document.querySelector(`a[href*="${id}"]`);
    if (element != null) {
      Object.assign(element.style, {
        border: "5px dotted springgreen",
        transform: "rotateZ(5deg)",
      });
      highlightedVideos += 1;
    }
  }
  console.log(
    `✅ Highlighted ${highlightedVideos} referenced video${
      highlightedVideos == 1 ? "" : "s"
    }`,
  );
}

/* FUNCTIONS */

async function findYouTubeIds(directoryHandle) {
  const ids = new Set();

  for await (const [name, handle] of directoryHandle.entries()) {
    if (handle.kind == "file" && name.endsWith(".md")) {
      const file = await handle.getFile();
      const text = await file.text();
      const matches = text.match(/(?<=youtu\.be\/)\w+/g);
      matches?.forEach((id) => ids.add(id));
    } else if (handle.kind == "directory" && name != ".obsidian") {
      const nestedIds = await findYouTubeIds(handle);
      nestedIds.forEach((id) => ids.add(id));
    }
  }

  return ids;
}
