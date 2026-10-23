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

### Bold, Italic and Strikethrough

**Explanation:** Use special characters around text to change its appearance.

**Markdown source:**

```markdown
**Bold text**
*Italic text*
~~Strikethrough text~~
```

**Expected result:** The first line is bold, the second italic, and the third crossed out.

### Inline Code

**Explanation:** Use backticks to display code within a sentence.

**Markdown source:**

```markdown
Use `print("Hello")` to display text in Python.
```

**Expected result:** The Python command appears as inline code.

## 2. Lists

### Unordered List

**Markdown source:**

```markdown
- Apple
- Banana
- Orange
```

**Expected result:** Three bullet points.

### Ordered List

**Markdown source:**

```markdown
1. First
2. Second
3. Third
```

**Expected result:** A numbered list with three items.

### Nested List

**Markdown source:**

```markdown
- Data
  - Open Data
  - Private Data
- Software
```

**Expected result:** Two main items, with two sub-items under Data.

### Task List

**Markdown source:**

```markdown
- [x] Create a GitHub repository
- [ ] Complete the cheat sheet
```

**Expected result:** A checked item and an unchecked item on GitHub.

## 3. Links and Images

### Link

**Markdown source:**

```markdown
[GitHub](https://github.com)
```

**Expected result:** A clickable link to GitHub.

### Image

**Markdown source:**

```markdown
![Example image](https://example.com/image.png)
```

**Expected result:** An image if the URL points to an accessible image file. This example URL may not display an actual image.

## 4. Code

### Fenced Code Block

**Markdown source:**

````markdown
```python
print("Hello, world!")
```
````

**Expected result:** A separate code block. GitHub may apply Python syntax highlighting.

## 5. Blockquotes

**Markdown source:**

```markdown
> This is a blockquote.
```

**Expected result:** The sentence appears as an indented quotation.

## 6. Tables

**Markdown source:**

```markdown
| Tool | Purpose |
| --- | --- |
| Python | Programming |
| GitHub | Version control hosting |
```

**Expected result:** A table with two columns and two data rows.

## 7. Horizontal Rules and Other Elements

### Horizontal Rule

**Markdown source:**

```markdown
---
```

**Expected result:** A horizontal line.

## 8. GitHub-Specific Features

### Emoji

**Markdown source:**

```markdown
:smile:
```

**Expected result:** GitHub may render the shortcode as a smile emoji.

### Mention

**Markdown source:**

```markdown
@github
```

**Expected result:** GitHub may turn a valid account mention into a profile link. Use a real account name when testing.

## 9. Pitfalls

Record at least three things you tested that did not work as expected. Explain what happened and how you fixed it.

1. **Problem:** [Describe your first issue.]
   **Solution:** [Describe how you solved it.]
2. **Problem:** [Describe your second issue.]
   **Solution:** [Describe how you solved it.]
3. **Problem:** [Describe your third issue.]
   **Solution:** [Describe how you solved it.]

