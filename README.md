# Exposition site

A [Quarto](https://quarto.org) blog for mathematical writing. Posts are Markdown files with LaTeX math, numbered theorem environments, cross-references, and an optional PDF version. GitHub builds the site on every push and serves it with GitHub Pages.

| Path | What it is |
|---|---|
| `_quarto.yml` | Site settings: title, navbar, theme |
| `index.qmd` | The Exposition page: a dated list of posts, with an RSS feed |
| `posts/` | One folder per post, each containing `index.qmd` (plus any images or PDFs) |
| `posts/_metadata.yml` | Defaults shared by every post |
| `_macros.qmd` | LaTeX macros shared by every post |
| `theme/` | Typography and colors for light and dark mode |
| `new-post.sh` | Creates a new draft post |
| `.github/workflows/publish.yml` | Builds and deploys the site |

## One-time setup

1. **Install Quarto** from <https://quarto.org/docs/get-started/>. If you want to build PDF versions on your own machine, also run `quarto install tinytex`.
2. **Preview locally.** In this folder, run `quarto preview`. A browser tab opens and reloads whenever you save a file. Check that the sample post looks right.
3. **Set the address.** In `_quarto.yml`, replace `YOUR-USERNAME` in `site-url` with your GitHub username.
4. **Create the repository.** On GitHub, create a public repository named exactly `YOUR-USERNAME.github.io`, then push this folder:
   ```
   git init -b main
   git add .
   git commit -m "Set up site"
   git remote add origin https://github.com/YOUR-USERNAME/YOUR-USERNAME.github.io.git
   git push -u origin main
   ```
5. **Turn on Pages.** In the repository, go to Settings → Pages → Build and deployment, and set Source to **GitHub Actions**. If the first build already failed because Pages wasn't on yet, open the Actions tab and choose Re-run all jobs. A minute or two later the site is live at `https://YOUR-USERNAME.github.io`.
6. **Link it from your Google Site.** In the Google Sites editor, open Pages, click **+**, choose **New link**, and enter "Exposition" with the address above.

## Writing a post

```
bash new-post.sh "Title of the post"
```

This creates `posts/YYYY-MM-DD-title-of-the-post/index.qmd` marked `draft: true`. Drafts appear in `quarto preview` but are left off the published site. When the post is ready, delete the `draft: true` line, then commit and push. The site updates on its own.

The repository is public, so a committed draft's source is readable on GitHub even though its page isn't published. If that matters, don't commit a post until it's done.

Fill in `description` (shown in the listing) and `categories` (shown as filters). Put images in the post's folder and include them with `![Caption](figure.png)`.

## Math syntax

Inline and display math work as in LaTeX: `$...$` and `$$...$$`.

**Numbered equations.** Put a label after the closing `$$`, then refer to it with `@`:

```
$$
a^2 + b^2 = c^2
$$ {#eq-pythagoras}

By @eq-pythagoras, ...
```

**Theorems and proofs.** The label's prefix sets the environment: `thm` theorem, `lem` lemma, `cor` corollary, `prp` proposition, `cnj` conjecture, `def` definition, `exm` example, `exr` exercise. They're numbered automatically. A heading inside the block is the optional name.

```
::: {#thm-main}
## Erdős–Ko–Rado
Statement.
:::

::: {.proof}
Proof.
:::

As @thm-main shows, ...
```

**Remarks and asides.** Use a callout:

```
::: {.callout-note}
## Remark
Text.
:::
```

**Macros.** Add them to `_macros.qmd`; every post includes that file on its first line after the front matter. They work in both the web page and the PDF.

**Citations.** Put a `references.bib` in the post's folder, add `bibliography: references.bib` to the front matter, and cite with `[@dvir2009]` or `@dvir2009`. A reference list appears at the end of the post.

## PDF versions

To give a post a PDF version, add this to its front matter (the sample post has it):

```
format:
  html: default
  pdf:
    documentclass: article
    geometry: margin=1in
    fontsize: 11pt
```

The post page then links to the PDF. Theorems, proofs, equation numbers, and macros carry over.

## Posting notes you already wrote in LaTeX

Create a post as usual, put the PDF in its folder, and write a short description with a link such as `[Read the notes (PDF)](notes.pdf)`. It appears in the listing like any other post.

## Moving to your own domain later

Buy a domain, enter it under Settings → Pages → Custom domain, follow GitHub's DNS instructions, and update `site-url` in `_quarto.yml`. GitHub redirects the old `github.io` address to the new domain, so existing links keep working.

## If a build fails

The Actions tab shows the log of each build. The usual causes are a LaTeX error in a post with a PDF version (fix it, or remove the `pdf` format from that post) or a change in a new Quarto release. For the latter, pin the last working version in `.github/workflows/publish.yml`; the comment there shows where.
