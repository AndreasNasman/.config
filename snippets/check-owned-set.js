document.querySelectorAll("#set-selection-menu input").forEach((element) => {
  if (
    [
      "Core Set",
      // Angmar Awakened
      "The Lost Realm",
      "The Wastes of Eriador",
      "Escape from Mount Gram",
      "Across the Ettenmoors",
      "The Treachery of Rhudaur",
      "The Battle of Carn Dûm",
      "The Dread Realm",
      // Dream-chaser
      "The Grey Havens",
      "Flight of the Stormcaller",
      "The Thing in the Depths",
      "Temple of the Deceived",
      "The Drowned Ruins",
      "A Storm on Cobas Haven",
      "The City of Corsairs",
      // Ered Mithrin
      "The Wilds of Rhovanion",
      "The Withered Heath",
      "Roam Across Rhovanion",
      "Fire in the Night",
      "The Ghost of Framsburg",
      "Mount Gundabad",
      "The Fate of Wilderland",
      // The Lord of the Rings
      "The Black Riders",
      "The Road Darkens",
      "The Treason of Saruman",
      "The Land of Shadow",
      "The Flame of the West",
      "The Mountain of Fire",
      // Starter decks
      "Dwarves of Durin",
      "Elves of Lórien",
      "Defenders of Gondor",
      "Riders of Rohan",
    ].includes(element.nextSibling.textContent)
  ) {
    element.checked = true;
  } else {
    element.checked = false;
  }
});
