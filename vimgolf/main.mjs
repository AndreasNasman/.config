import challenges from "./challenges.json" assert { type: "json" };
import { execSync } from "child_process";

const args = process.argv.slice(2);

if (args.includes("--all")) {
  playAllChallenges();
} else if (args.length == 0 || args.includes("--last")) {
  playLastChallenge();
} else {
  console.error("❌ Unknown flag.");
}

/* FUNCTIONS */

async function loadChallenge(challenge) {
  const { id, score, name } = challenge;
  console.log(`🥷  Next challenge: ${name}`);
  console.log(`🧩 Lowest score: ${score}`);

  await new Promise((r) => setTimeout(r, 1000));
  const output = execSync(`vimgolf put ${id}`, { stdio: "inherit" });
}

async function playAllChallenges() {
  for (const challenge of challenges) {
    await loadChallenge(challenge);
  }
}

async function playLastChallenge() {
  const lastChallenge = challenges.at(-1);
  await loadChallenge(lastChallenge);
}
