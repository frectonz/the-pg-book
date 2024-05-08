import essays from "../essays.json" with { type: "json" };

essays.reverse();
let index = 1;
for (const essay of essays) {
  const content = `${essay.url}
${essay.title}

${essay.body}
`;

  await Deno.writeTextFile(
    `book/${index.toString().padStart(3, "0")}. ${essay.url}.typ`,
    content,
  );
  index += 1;
}
