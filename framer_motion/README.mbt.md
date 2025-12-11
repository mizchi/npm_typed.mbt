# mizchi/npm_typed/framer_motion

MoonBit FFI bindings for [framer-motion](https://www.npmjs.com/package/framer-motion).

## Installation

```bash
moon add mizchi/js
moon add mizchi/npm_typed
npm install framer-motion
```

Add to your `moon.pkg.json`:

```json
{
  "import": [
    "mizchi/js/core",
    "mizchi/js/browser/dom",
    "mizchi/npm_typed/framer_motion"
  ]
}
```

## TODO

- [ ] Add typed keyframes/options structs
- [ ] Add MotionValue type wrapper
- [ ] Add scroll animation options
- [ ] Test in browser environment

## Basic Usage

```mbt test
// Basic API check
inspect(@framer_motion.mix(0.0, 100.0, 0.5), content="50")
```

## API

### animate

```moonbit
// With selector

///|
let controls = animate_selector(".box", keyframes, options~)

// With DOM Element

///|
let controls = animate_element(element, keyframes, options~)

// Raw version (accepts any)

///|
let controls = animate(@core.any(".box"), keyframes, options~)
```

### inView

```moonbit
// With selector

///|
let cleanup = inView_selector(".box", fn(entry) { ... }, options~)

// With DOM Element

///|
let cleanup = inView_element(element, fn(entry) { ... }, options~)
```

### Playback Controls

```moonbit
let controls = animate_selector(".box", keyframes)
controls.play()
controls.pause()
controls.stop()
controls.cancel()
controls.complete()
```

### MotionValue

```moonbit
let x = motionValue(@core.any(0))
mv_set(x, @core.any(100))
let current = mv_get(x)

// Subscribe to changes
let cleanup = mv_on(x, "change", fn(v) { ... })
```

### Utilities

```moonbit
// Mix values

///|
let value = mix(0.0, 100.0, 0.5) // => 50.0

// Stagger animations

///|
let delay = stagger(0.1)

// Delay callback

///|
let cancel = delay(fn() { ... }, 1.0)

// Transform values between ranges

///|
let result = transform(value, [0.0, 100.0], [@core.any(0), @core.any(1)])
```

## See Also

- [npm package](https://www.npmjs.com/package/framer-motion)
- [framer-motion documentation](https://www.framer.com/motion/)
