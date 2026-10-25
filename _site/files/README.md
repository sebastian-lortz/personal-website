# Files

Downloadable material for the website. Quarto copies a file into the built
site automatically as soon as a page links to it.

## Folders

- `publications/` – paper PDFs (accepted manuscripts, preprints)
- `presentations/` – slides and posters
- `teaching/` – teaching materials

## File names

Start with the date so files sort chronologically:
`YYYY-MM_short-name.pdf`, e.g. `2024-11_irt-workshop_mokken.pdf`.

## Linking

Add the link at the end of the entry in `_content/`. Use the full site URL so
the link also works in the downloaded CV PDF:

```markdown
[Slides](https://sebastian-lortz.github.io/personal-website/files/presentations/2024-11_irt-workshop_mokken.pdf)
[PDF](https://sebastian-lortz.github.io/personal-website/files/publications/2026-01_ssp-2x2-anova.pdf)
```

A new file is only reachable after the site has been rendered and pushed.
