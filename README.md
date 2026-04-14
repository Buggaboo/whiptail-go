# Whiptail-Go

A modern Go reimplementation of [Dialog](https://en.wikipedia.org/wiki/Dialog_(software)) using [Charm's Huh](https://github.com/charmbracelet/huh) library for beautiful, interactive terminal dialogs.

[![Go Version](https://img.shields.io/badge/go-%3E%3D1.21-blue)](https://golang.org/)
[![Huh Version](https://img.shields.io/badge/huh-v2.0.3-purple)](https://charm.land/huh/v2)
[![License](https://img.shields.io/badge/license-MIT-green)]()

## Overview

Whiptail-Go provides a drop-in replacement for the classic Whiptail utility, reimagined with modern terminal UI capabilities. Built on top of Charm's Huh library, it offers:

- 🎨 Beautiful, accessible terminal interfaces
- ⌨️ Full keyboard navigation (arrow keys, vim keys, tab/shift-tab)
- 🖱️ Mouse support in compatible terminals
- 🎯 Whiptail-compatible exit codes and output format
- 🚀 Easy to extend and customize

## Usage

Install with Go:

```sh
go install github.com/Buggaboo/whiptail-go@main
```


## License

[MIT](https://github.com/buggaboo/whiptail-go/blob/main/LICENSE)


Whiptail-Go aims to be compatible with Whiptail's command-line interface:

```bash
# Menu selection
./whiptail --menu "Select an option" 15 40 4 \
    1 "Option One" \
    2 "Option Two" \
    3 "Option Three" \
    4 "Option Four"

# Yes/No dialog
./whiptail --yesno "Do you want to continue?" 7 40

# Input box
./whiptail --inputbox "Enter your name:" 8 40

# Password box
./whiptail --passwordbox "Enter password:" 8 40

# Checklist (multiple selection)
./whiptail --checklist "Select toppings" 12 50 4 \
    1 "Lettuce" on \
    2 "Tomatoes" on \
    3 "Cheese" off \
    4 "Bacon" off

# Radiolist (single selection with pre-selection)
./whiptail --radiolist "Choose size" 10 40 3 \
    1 "Small" off \
    2 "Medium" on \
    3 "Large" off

# Message box
./whiptail --msgbox "Operation completed successfully!" 7 40
```

## Supported Widgets

| Widget | Status | Description |
|--------|--------|-------------|
| `--menu` | ✅ | Scrollable selection list |
| `--yesno` | ✅ | Yes/No confirmation dialog |
| `--msgbox` | ✅ | Message display with OK button |
| `--inputbox` | ✅ | Text input field |
| `--passwordbox` | ✅ | Password input (hidden characters) |
| `--checklist` | ✅ | Multi-select checklist with pre-selection support |
| `--radiolist` | ✅ | Single-select list with pre-selection support |
| `--infobox` | ❌ | Non-blocking info display (not implemented) |
| `--gauge` | ❌ | Progress bar (not implemented - use `--infobox` with external progress) |

## Exit Codes

Whiptail-Go follows Whiptail's exit code conventions:

| Exit Code | Meaning |
|-----------|---------|
| `0` | Success / Yes / Item selected |
| `1` | Cancel / No / ESC pressed / No selection |
| `255` | Error (invalid arguments, runtime error, etc.) |

## Keyboard Controls

### Navigation
- **↑/↓** or **k/j** - Navigate up/down
- **Tab** - Next field
- **Shift+Tab** - Previous field
- **Space** - Toggle selection (checklist)
- **Enter** - Confirm/OK
- **Esc** - Cancel (returns exit code 1)
- **Ctrl+C** - Cancel (returns exit code 1)

### Special Keys
- **g/Home** - Jump to first item
- **G/End** - Jump to last item
- **Ctrl+A** - Select all (checklist)
- **/ or Ctrl+F** - Filter/search (when enabled)

## Options

| Option | Description | Status |
|--------|-------------|--------|
| `--title <title>` | Set dialog title | ✅ |
| `--backtitle <title>` | Set backtitle (background title) | 🚧 TODO |
| `--clear` | Clear screen on exit | 🚧 TODO |
| `--default-item <tag>` | Set default selected item | 🚧 TODO |
| `--scrolltext` | Enable scrolling for long text | 🚧 TODO |
| `--help` | Show help message | ✅ |

## Project Structure

```
whiptail-go/
├── cmd/
│   └── whiptail/
│       └── main.go          # Main application entry point
├── internal/
│   ├── widgets/             # Widget implementations (future)
│   ├── parser/              # Argument parser (future)
│   └── compat/              # Whiptail compatibility layer (future)
├── examples/
│   └── test_whiptail.sh     # Comprehensive test suite
├── go.mod                   # Go module definition
└── go.sum                   # Go module checksums
```

## Testing

Run the comprehensive test suite:

```bash
cd whiptail-go
./examples/test_whiptail.sh
```

This will test all implemented widgets and verify exit codes.

## Differences from Original Whiptail

### Improvements
- **Modern UI**: Beautiful, themable interface using Lip Gloss
- **Better UX**: Keyboard shortcuts, filtering, and mouse support
- **Type Safety**: Written in Go with proper error handling
- **Extensibility**: Easy to add new widgets and themes

### Limitations
- `--infobox` is not implemented (requires non-blocking UI)
- `--gauge` is not implemented (use external progress with `--infobox`)
- `--backtitle` requires custom Lip Gloss implementation
- Output is always to stderr (Whiptail convention)

## Dependencies

- [Go](https://golang.org/) >= 1.21
- [charm.land/huh/v2](https://charm.land/huh/v2) v2.0.3 - Forms and dialogs
- [charmbracelet/bubbletea](https://github.com/charmbracelet/bubbletea) - TUI framework
- [charmbracelet/lipgloss](https://github.com/charmbracelet/lipgloss) - Styling

## Development

### Building

```bash
go build -o whiptail ./cmd/whiptail
```

### Running Tests

```bash
cd examples
./test_whiptail.sh
```

### Adding a New Widget

1. Add the widget type to the `WidgetType` enum
2. Add argument parsing in `parseArgs()`
3. Implement the widget function following the existing pattern
4. Add the case to the switch statement in `main()`
5. Update this README

## Troubleshooting

### ESC key not working
Make sure your terminal supports the escape key sequence. Some terminals may require configuring key bindings.

### Pre-selection not working
Ensure you're using `on`/`off` (lowercase) for checklist/radiolist status:
```bash
# Good
./whiptail --radiolist "Test" 10 40 2 1 "A" on 2 "B" off

# Bad
./whiptail --radiolist "Test" 10 40 2 1 "A" ON 2 "B" OFF
```

## Contributing

Contributions are welcome! Areas for improvement:

- [ ] Implement `--infobox` (non-blocking display)
- [ ] Implement `--gauge` with real-time updates
- [ ] Add `--backtitle` support using Lip Gloss with settings support: ~/.config/whiptail.toml (?)
- [ ] Add `--output-stdout` flag for configurable output
- [ ] Add more themes
- [ ] Improve accessibility

## License

MIT License - See LICENSE file for details.

## Acknowledgments

- [Charm](https://charm.sh/) for the excellent Huh, Bubble Tea, and Lip Gloss libraries
- The original [Dialog](https://en.wikipedia.org/wiki/Dialog_(software)) developers for the inspiration
- The Go community for excellent tooling and libraries

## See Also

- [Huh Documentation](https://github.com/charmbracelet/huh)
- [Bubble Tea Documentation](https://github.com/charmbracelet/bubbletea)
- [Whiptail Man Page](https://linux.die.net/man/1/whiptail)
