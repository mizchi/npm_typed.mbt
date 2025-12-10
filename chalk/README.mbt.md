# mizchi/npm_typed/chalk

MoonBit FFI bindings for [chalk](https://github.com/chalk/chalk) - Terminal string styling done right.

## Installation

```bash
moon add mizchi/js
moon add mizchi/npm_typed
npm install chalk
```

Add to your `moon.pkg.json`:

```json
{
  "import": [
    "mizchi/js",
    "mizchi/js/core",
    "mizchi/npm_typed/chalk"
  ]
}
```

## Basic Colors

```mbt test
// Foreground colors
let r = @chalk.red("hello")
inspect(r.contains("hello"), content="true")
let g = @chalk.green("world")
inspect(g.contains("world"), content="true")
let b = @chalk.blue("test")
inspect(b.contains("test"), content="true")
let y = @chalk.yellow("warning")
inspect(y.contains("warning"), content="true")
```

## Text Modifiers

```mbt test
// Bold
let bold_text = @chalk.bold("strong")
inspect(bold_text.contains("strong"), content="true")

// Italic
let italic_text = @chalk.italic("emphasis")
inspect(italic_text.contains("emphasis"), content="true")

// Underline
let underlined = @chalk.underline("underlined")
inspect(underlined.contains("underlined"), content="true")

// Dim
let dimmed = @chalk.dim("dimmed")
inspect(dimmed.contains("dimmed"), content="true")

// Strikethrough
let crossed = @chalk.strikethrough("crossed")
inspect(crossed.contains("crossed"), content="true")

// Inverse
let inverted = @chalk.inverse("inverted")
inspect(inverted.contains("inverted"), content="true")
```

## Background Colors

```mbt test
let bg_red = @chalk.bgRed("error")
inspect(bg_red.contains("error"), content="true")
let bg_green = @chalk.bgGreen("success")
inspect(bg_green.contains("success"), content="true")
```

## Bright Colors

```mbt test
let bright = @chalk.redBright("bright red")
inspect(bright.contains("bright red"), content="true")
```

## Chainable Instance

```mbt test
// Create a chainable chalk instance
let c = @chalk.instance()

// Chain styles
let styled = c.red().bold()
inspect(@core.typeof_(styled.as_any()), content="function")
let blue_bold = @chalk.instance().blue().bold()
inspect(@core.typeof_(blue_bold.as_any()), content="function")
let warning_style = @chalk.instance().bgYellow().black()
inspect(@core.typeof_(warning_style.as_any()), content="function")
```

## RGB and Hex Colors

```mbt test
// RGB color
let rgb_style = @chalk.rgb(255, 136, 0)
inspect(@core.typeof_(rgb_style.as_any()), content="function")

// Hex color
let hex_style = @chalk.hex("#FF8800")
inspect(@core.typeof_(hex_style.as_any()), content="function")

// Background RGB
let bg_rgb = @chalk.bgRgb(100, 50, 200)
inspect(@core.typeof_(bg_rgb.as_any()), content="function")

// Background Hex
let bg_hex = @chalk.bgHex("#112233")
inspect(@core.typeof_(bg_hex.as_any()), content="function")
```

## Gray/Grey Alias

```mbt test
// Both gray and grey work
let g1 = @chalk.gray("test")
let g2 = @chalk.grey("test")
inspect(g1.contains("test"), content="true")
inspect(g2.contains("test"), content="true")
```

## See Also

- [chalk Documentation](https://github.com/chalk/chalk)
