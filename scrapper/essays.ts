import {
  DOMParser,
  Element,
} from "https://deno.land/x/deno_dom@v0.1.45/deno-dom-wasm.ts";

async function getDocument(url: string) {
  const page = await fetch(url);
  const html = await page.text();
  const parser = new DOMParser();
  return parser.parseFromString(html, "text/html");
}

try {
  const doc = await getDocument("http://paulgraham.com/articles.html");

  if (doc === null) {
    console.error("Failed to parse page.");
  } else {
    const essays = Array.from(
      doc.querySelectorAll("td:nth-child(3) table:nth-child(6) a"),
    ).map((x) => ({
      url: (x as Element).outerHTML.split('<a href="')[1].split(
        '">',
      )[0] as string,
      title: x.textContent,
      body: "",
    })).filter(({ url }) => url.endsWith(".html"));

    const bodies = [];

    for (const essay of essays) {
      console.log("Fetching", essay.title);

      const doc = (await getDocument(`https://paulgraham.com/${essay.url}`))!;
      const table = doc.querySelector("table")!;

      bodies.push({ ...essay, body: table.textContent });
    }

    const json = JSON.stringify(bodies, null, 2);
    await Deno.writeTextFile("essays.json", json);
  }
} catch (err) {
  console.error("Got error", err);
}
