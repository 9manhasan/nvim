# Neovim Configuration
```markdown
## Installation

Clone the repository with the following command:

bash
git clone https://github.com/9manhasan/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
```

## Neovim Keybindings Guide

### General Notes

- The leader key is set to the space bar (`<Space>`).
- In the keybindings below, `<Leader>` refers to the space bar.
- `<CR>` stands for "Carriage Return," which is the Enter key.

### File Navigation

#### NvimTree (File Explorer)

| Keybinding  | Action                | Description                      |
| ----------- | --------------------- | -------------------------------- |
| `<Leader>e` | `:NvimTreeToggle<CR>` | Toggle the file explorer sidebar |

**Usage:** Press `<Space>e` to open or close the file explorer. Use it to navigate your project structure, open files, and perform file operations.

#### Telescope (Fuzzy Finder)

| Keybinding | Action                      | Description                             |
|------------|-----------------------------|-----------------------------------------|
| `<Leader>sf` | `:Telescope find_files<CR>` | Search for files in your project        |
| `<Leader>sg` | `:Telescope live_grep<CR>` | Search for a string in your project     |
| `<Leader>sb` | `:Telescope buffers<CR>`   | List open buffers                       |
| `<Leader>p` | `:Telescope projects<CR>`   | List and switch between projects        |

**Usage:**
- Press `<Space>sf` to quickly find and open files in your project.
- Use `<Space>sg` to search for specific text across all files in your project.
- `<Space>sb` helps you switch between open buffers quickly.
- `<Space>p` allows you to manage and switch between different projects.

### Git Integration

| Keybinding | Action          | Description                          |
|------------|-----------------|--------------------------------------|
| `<Leader>lg` | `:LazyGit<CR>` | Open LazyGit interface               |

**Usage:** Press `<Space>lg` to open the LazyGit interface, which provides a user-friendly way to manage Git operations.

### Window Management

#### Split Windows

| Keybinding | Action        | Description                        |
|------------|---------------|------------------------------------|
| `<Leader>sv` | `:vsp<CR>`   | Split window vertically            |
| `<Leader>sh` | `:sp<CR>`    | Split window horizontally          |
| `<Leader>sc` | `<C-w>c`    | Close the current split window     |
| `<Leader>so` | `<C-w>o`    | Close all split windows except the current one |
| `<Leader>sr` | `<C-w>r`    | Rotate split windows               |

**Usage:**
- Use `<Space>sv` to create a vertical split.
- Use `<Space>sh` to create a horizontal split.
- `<Space>sc` closes the current split window.
- `<Space>so` keeps only the current split window open.
- `<Space>sr` rotates the arrangement of split windows.

#### Tmux Navigation

| Keybinding | Action                  | Description                         |
|------------|-------------------------|-------------------------------------|
| `<C-h>`    | `:TmuxNavigateLeft<CR>` | Move to the left split              |
| `<C-j>`    | `:TmuxNavigateDown<CR>` | Move to the split below             |
| `<C-k>`    | `:TmuxNavigateUp<CR>`   | Move to the split above             |
| `<C-l>`    | `:TmuxNavigateRight<CR>`| Move to the right split             |

**Usage:** Use these keybindings to navigate between split windows in Neovim and Tmux panes seamlessly.

### Tab Management

| Keybinding | Action        | Description                        |
|------------|---------------|------------------------------------|
| `<Leader>tn` | `:tabnew<CR>` | Open a new tab                     |
| `<Leader>to` | `:tabonly<CR>`| Close all other tabs               |
| `<Leader>tc` | `:tabclose<CR>` | Close the current tab             |
| `<Leader>tm` | `:tabmove<CR>` | Move the current tab               |

**Usage:**
- `<Space>tn` creates a new tab.
- `<Space>to` closes all tabs except the current one.
- `<Space>tc` closes the current tab.
- `<Space>tm` allows you to move the current tab to a different position.

### Terminal

| Keybinding | Action      | Description                   |
|------------|-------------|-------------------------------|
| `<Leader>t` | `:term<CR>` | Open a terminal window        |

**Usage:** Press `<Space>t` to open a terminal window within Neovim.

### Movement

| Keybinding | Action        | Description                                |
|------------|---------------|--------------------------------------------|
| `<C-d>`    | `<C-d>zz`     | Scroll down half a page and center the cursor |
| `<C-u>`    | `<C-u>zz`     | Scroll up half a page and center the cursor   |
| `n`        | `nzzzv`       | Go to next search result and center the view |
| `N`        | `Nzzzv`       | Go to previous search result and center the view |

**Usage:**
- Use `Ctrl+d` and `Ctrl+u` to scroll down and up, keeping your cursor in the middle of the screen.
- When searching, use `n` and `N` to jump between results while keeping your view centered.

### Disabled Arrow Keys

| Keybinding | Action         | Description                                 |
|------------|----------------|---------------------------------------------|
| `<left>`   | Display message | Reminds you to use 'h' for left movement   |
| `<right>`  | Display message | Reminds you to use 'l' for right movement  |
| `<up>`     | Display message | Reminds you to use 'k' for upward movement |
| `<down>`   | Display message | Reminds you to use 'j' for downward movement |

**Usage:** These keybindings are designed to help you break the habit of using arrow keys and encourage using h, j, k, l for navigation in normal mode.

### Additional Notes

- The configuration includes highlighting of yanked (copied) text for visual feedback.
- The color scheme is set to "tokyonight". You can change this in the configuration if desired.
- Case-insensitive searching is enabled by default, but becomes case-sensitive if you include capital letters in your search term.
- The configuration uses relative line numbers, which can be helpful for quick navigation.

**Tip for Newcomers:**
1. Start by mastering the basic movement keys (h, j, k, l) and the leader key commands.
2. Gradually incorporate Telescope commands for efficient file navigation.
3. Experiment with window splits and tabs to find your preferred workflow.
4. Don't hesitate to customize these keybindings to suit your needs!

---

Feel free to adjust the keybindings and settings according to your preferences and workflow. Happy editing!

---

Follow me on Twitter: [@9manhasan_](https://twitter.com/9manhasan_)
