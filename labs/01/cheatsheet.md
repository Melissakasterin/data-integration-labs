
# Markdown Cheat Sheet

## Table of Contents

- [1. Text Formatting](#1-text-formatting)
- [2. Lists](#2-lists)
- [3. Links and Images](#3-links-and-images)
- [4. Code](#4-code)
- [5. Blockquotes](#5-blockquotes)
- [6. Tables](#6-tables)
- [7. Horizontal Rules and Other Elements](#7-horizontal-rules-and-other-elements)
- [8. GitHub-Specific Features](#8-github-specific-features)
- [9. Pitfalls](#9-pitfalls)

## 1. Text Formatting

### Headings

**Explanation:** Use `#` symbols to create headings. More symbols mean a smaller heading.

**Markdown source:**

```markdown
# Heading 1
## Heading 2
### Heading 3
```

**Expected result:** Three headings with decreasing sizes.

**Classification:** CommonMark

### Paragraphs and Line Breaks

**Explanation:** A blank line separates paragraphs. Two spaces at the end of a line create a line break.

**Markdown source:**

```markdown
First paragraph.

Second paragraph.

First line  
Second line
```

**Expected result:** Two paragraphs and a line break between the last two lines.

**Classification:** CommonMark

### Bold, Italic and Strikethrough

**Explanation:** Special characters change the appearance of text.

**Markdown source:**

```markdown
**Bold text**
*Italic text*
***Bold and italic text***
~~Strikethrough text~~
```

**Expected result:** Bold, italic, bold and italic, and crossed-out text.

**Classification:** Bold and italic: CommonMark. Strikethrough: GitHub.

### Escaping Characters

**Explanation:** A backslash prevents Markdown characters from being interpreted as formatting.

**Markdown source:**

```markdown
\*This text is not italic\*
```

**Expected result:** The asterisks appear literally.

**Classification:** CommonMark

### Inline Code

**Explanation:** Use backticks to display code within a sentence.

**Markdown source:**

```markdown
Use `print("Hello")` to display text in Python.
```

**Expected result:** The Python command appears as inline code.

**Classification:** CommonMark

## 2. Lists

### Unordered List

**Markdown source:**

```markdown
- Apple
- Banana
- Orange
```

**Expected result:** Three bullet points.

**Classification:** CommonMark

### Ordered List

**Markdown source:**

```markdown
1. First
2. Second
3. Third
```

**Expected result:** A numbered list with three items.

**Classification:** CommonMark

### Nested List

**Markdown source:**

```markdown
- Data
  - Open Data
  - Private Data
- Software
```

**Expected result:** Two main items, with two sub-items under Data.

**Classification:** CommonMark

### Task List

**Markdown source:**

```markdown
- [x] Create a GitHub repository
- [ ] Complete the cheat sheet
```

**Expected result:** A checked item and an unchecked item on GitHub.

**Classification:** GitHub

## 3. Links and Images

### Inline Link

**Markdown source:**

```markdown
[GitHub](https://github.com)
```

**Expected result:** A clickable link to GitHub.

**Classification:** CommonMark

### Reference-Style Link

**Markdown source:**

```markdown
[GitHub][website]

[website]: https://github.com
```

**Expected result:** A clickable link using a reference definition.

**Classification:** CommonMark

### Relative Link to Another File

**Markdown source:**

```markdown
[Repository README](../../README.md)
```

**Expected result:** A link from this cheatsheet to the repository's README file.

**Classification:** CommonMark

### Link to a Section

**Markdown source:**

```markdown
[Go to Text Formatting](#1-text-formatting)
```

**Expected result:** On GitHub, clicking the link jumps to the Text Formatting section.

**Classification:** GitHub

### Image with Alternative Text

**Markdown source:**

```markdown
![Example image](https://example.com/image.png)
```

**Expected result:** An image appears if the URL points to an accessible image file. Alternative text can describe the image to screen-reader users or appear if the image cannot be loaded.

**Classification:** CommonMark

### Image That Is a Link

**Markdown source:**

```markdown
[![Example image](https://example.com/image.png)](https://github.com)
```

**Expected result:** Clicking the image opens GitHub if the image loads.

**Classification:** CommonMark

## 4. Code

### Fenced Code Block

**Explanation:** Triple backticks create a separate code block. A language identifier can enable syntax highlighting in supported renderers.

**Markdown source:**

````markdown
```
This is a code block.
```
````

**Expected result:** A separate block containing the text.

**Classification:** CommonMark

### Python Code Block

**Markdown source:**

````markdown
```python
print("Hello, world!")
```
````

**Expected result:** A code block containing Python code. GitHub normally highlights the syntax.

**Classification:** CommonMark (code block); GitHub (syntax highlighting)

### Bash Code Block

**Markdown source:**

````markdown
```bash
echo "Hello, world!"
```
````

**Expected result:** A code block containing Bash code. GitHub normally highlights the syntax.

**Classification:** CommonMark (code block); GitHub (syntax highlighting)

### JSON Code Block

**Markdown source:**

````markdown
```json
{
  "course": "Data Integration",
  "lab": 1
}
```
````

**Expected result:** A code block containing JSON. GitHub normally highlights the syntax.

**Classification:** CommonMark (code block); GitHub (syntax highlighting)

## 5. Blockquotes

### Blockquote

**Markdown source:**

```markdown
> This is a blockquote.
```

**Expected result:** The sentence appears as an indented quotation.

**Classification:** CommonMark

### Nested Blockquotes and Formatting

**Markdown source:**

```markdown
> First level
>
> > Second level with **bold text**
```

**Expected result:** A quotation inside another quotation, with bold text.

**Classification:** CommonMark

### GitHub Alerts

**Markdown source:**

```markdown
> [!NOTE]
> This is a note.
```

**Expected result:** GitHub displays a note-style alert.

**Classification:** GitHub

## 6. Tables

### Basic Table

**Markdown source:**

```markdown
| Tool | Purpose |
| --- | --- |
| Python | Programming |
| GitHub | Version control hosting |
```

**Expected result:** A table with two columns and two data rows.

**Classification:** GitHub

### Aligned Table

**Markdown source:**

```markdown
| Left | Center | Right |
| :--- | :---: | ---: |
| A | B | C |
```

**Expected result:** The first column is left-aligned, the second centered, and the third right-aligned.

**Classification:** GitHub

### Table with a Link and an Escaped Pipe

**Markdown source:**

```markdown
| Tool | Description |
| --- | --- |
| [GitHub](https://github.com) | A \| B |
```

**Expected result:** A table containing a link and a literal pipe character inside a cell.

**Classification:** GitHub

## 7. Horizontal Rules and Other Elements

### Horizontal Rule

**Markdown source:**

```markdown
---
```

**Expected result:** A horizontal line.

**Classification:** CommonMark

### HTML Comments

**Markdown source:**

```html
<!-- This comment is not normally visible in the rendered page. -->
Visible text.
```

**Expected result:** Only "Visible text." appears in the rendered page.

**Classification:** CommonMark

### Collapsible Section

**Markdown source:**

```html
<details>
<summary>Show details</summary>

This content is hidden until expanded.

</details>
```

**Expected result:** GitHub displays a collapsible section. Click "Show details" to reveal the hidden content.

**Classification:** GitHub

## 8. GitHub-Specific Features

### Emoji Shortcodes

**Markdown source:**

```markdown
:smile:
```

**Expected result:** GitHub renders the shortcode as a smile emoji.

**Classification:** GitHub

### Mentions and Issue References

**Markdown source:**

```markdown
@github
#1
```

**Expected result:** GitHub may turn a valid account mention or issue reference into a link. The issue reference works only if the relevant issue exists in the repository.

**Classification:** GitHub

### Footnotes

**Markdown source:**

```markdown
Here is a statement with a footnote.[^1]

[^1]: This is the footnote text.
```

**Expected result:** GitHub renders a footnote reference and its corresponding note.

**Classification:** GitHub

### Mermaid Diagram

**Explanation:** Mermaid creates diagrams from text.

**Markdown source:**

````markdown
```mermaid
flowchart TD
    A[Find data] --> B[Clean data]
    B --> C[Analyse data]
```
````

**Expected result:** A flowchart with three steps: Find data, Clean data, and Analyse data.

**Classification:** GitHub

### Mathematical Formula

**Explanation:** GitHub supports mathematical expressions using LaTeX syntax.

**Markdown source:**

````markdown
```math
E = mc^2
```
````

**Expected result:** The formula is displayed as a mathematical equation.

**Classification:** GitHub

## 9. Pitfalls

Record at least three things you tested that did not work as expected. Explain what happened and how you fixed it. The examples below are suggestions; keep them only if they match what you actually observed.

1. **Problem:** Strikethrough did not work in CommonMark Dingus.  
   **Solution:** I labelled strikethrough as GitHub-specific because GitHub supports it.

2. **Problem:** The Mermaid diagram did not appear immediately.  
   **Solution:** I saved the file and checked the rendered result on GitHub.

3. **Problem:** A placeholder image URL did not display an image.  
   **Solution:** I explained that the URL must point to an accessible image file.
