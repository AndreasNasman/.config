import challenges from "./challenges.json" assert { type: "json" };
import { execSync } from "child_process";
import { readFileSync } from "fs";

const args = process.argv.slice(2);

if (args.includes("--all")) {
  playAllChallenges();
} else if (args.some((element) => /^--id=\w+$/.test(element))) {
  playChallengeById();
} else if (args.length == 0 || args.includes("--last")) {
  playLastChallenge();
} else {
  throw new Error("❌ Unknown flag.");
}

/* FUNCTIONS */

async function loadChallenge(challenge, repeat = false) {
  let { id, score, name } = challenge;
  console.log(`\n🥷  ${repeat ? "Repeating" : "Next"} challenge: ${name}`);
  console.log(`🎲 Lowest score: ${score}`);

  await new Promise((r) => setTimeout(r, 2000));
  execSync(`vimgolf put ${id}`, { stdio: "inherit" });

  const logFile = readFileSync("./console.log", {
    encoding: "utf8",
    flag: "r",
  });
  const newestLines = logFile.split("\r\n").reverse();
  const scoreLine = newestLines.find((line) => line.includes("Your score"));

  if (scoreLine.toLowerCase().includes("fail")) return;
  else if (scoreLine.toLowerCase().includes("success")) {
    const [currentScore] = scoreLine.match(/(?<=: )\d+/);
    if (currentScore == score)
      console.log("💪 Good job! On to the next challenge! 🧑‍💻");
    else if (currentScore > score) {
      console.log(
        `🧩 The challenge can still be optimized to a score of ${score}, try again! 🤔`
      );
      return loadChallenge(challenge, true);
    } else if (currentScore < score) {
      console.log(
        "🤯 Wow! A new solution found! Update the challenges file! 🤩"
      );
      process.exit();
    } else throw new Error("Unknown scoring.");
  } else throw new Error("Unhandled score line format.");
}

async function playAllChallenges() {
  let relevantChallenges = [...challenges];

  if (args.includes("--noteworthy"))
    relevantChallenges = relevantChallenges.filter(
      (challenge) => challenge.noteworthy
    );
  if (args.includes("--random"))
    relevantChallenges.sort(() => 0.5 - Math.random());
  if (args.includes("--revised"))
    relevantChallenges = relevantChallenges.filter(
      (challenge) => challenge.revised
    );

  for (const challenge of relevantChallenges) {
    await loadChallenge(challenge);
  }
}

async function playChallengeById() {
  const [challegeArgument] = args;
  const { challengeId } = challegeArgument.match(
    /^--id=(?<challengeId>\w+)$/
  ).groups;
  const challengeToLoad = challenges.find(
    (challenge) => challenge.id === challengeId
  );

  if (!challengeToLoad) throw new Error("Provide a valid challenge ID!");

  await loadChallenge(challengeToLoad);
}

async function playLastChallenge() {
  const lastChallenge = challenges.at(-1);
  await loadChallenge(lastChallenge);
}

// CTRL-C should return to parent script for cleanup to run.
process.on("SIGINT", () => {
  process.exit();
});
