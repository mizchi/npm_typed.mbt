# mizchi/npm_typed/date_fns

MoonBit FFI bindings for [date-fns](https://date-fns.org/) - Modern JavaScript date utility library.

## Installation

```bash
moon add mizchi/js
moon add mizchi/npm_typed
npm install date-fns
```

Add to your `moon.pkg.json`:

```json
{
  "import": [
    "mizchi/js",
    "mizchi/js/core",
    "mizchi/npm_typed/date_fns"
  ]
}
```

## Parsing and Formatting

```mbt test
// Create date from year, month (0-indexed), day
let date = @date_fns.fromYMD(2024, 0, 15) // January 15, 2024

// Format date
inspect(@date_fns.format(date, "yyyy-MM-dd"), content="2024-01-15")
inspect(@date_fns.format(date, "MMMM d, yyyy"), content="January 15, 2024")

// Parse ISO string
let parsed = @date_fns.parseISO("2024-03-15")
inspect(@date_fns.isValid(parsed), content="true")
inspect(@date_fns.getYear(parsed), content="2024")
inspect(@date_fns.getMonth(parsed), content="2") // March = 2 (0-indexed)
inspect(@date_fns.getDate(parsed), content="15")
```

## Date Comparison

```mbt test
let date1 = @date_fns.fromYMD(2024, 0, 1)
let date2 = @date_fns.fromYMD(2024, 0, 15)

// Before / After
inspect(@date_fns.isBefore(date1, date2), content="true")
inspect(@date_fns.isAfter(date2, date1), content="true")

// Same day check
let date3 = @date_fns.fromYMD(2024, 0, 15)
inspect(@date_fns.isSameDay(date2, date3), content="true")

// Compare ascending (-1, 0, 1)
inspect(@date_fns.compareAsc(date1, date2), content="-1")
inspect(@date_fns.compareAsc(date2, date1), content="1")
inspect(@date_fns.compareAsc(date1, date1), content="0")
```

## Date Differences

```mbt test
let date1 = @date_fns.fromYMD(2024, 0, 1)
let date2 = @date_fns.fromYMD(2024, 0, 11)
inspect(@date_fns.differenceInDays(date2, date1), content="10")
let jan = @date_fns.fromYMD(2024, 0, 1)
let jul = @date_fns.fromYMD(2024, 6, 1)
inspect(@date_fns.differenceInMonths(jul, jan), content="6")
let y2020 = @date_fns.fromYMD(2020, 0, 1)
let y2024 = @date_fns.fromYMD(2024, 0, 1)
inspect(@date_fns.differenceInYears(y2024, y2020), content="4")
```

## Date Manipulation

```mbt test
let date = @date_fns.fromYMD(2024, 0, 15)

// Add/subtract days
inspect(@date_fns.getDate(@date_fns.addDays(date, 10)), content="25")
inspect(@date_fns.getDate(@date_fns.subDays(date, 10)), content="5")

// Add/subtract months
let jan = @date_fns.fromYMD(2024, 0, 15)
inspect(@date_fns.getMonth(@date_fns.addMonths(jan, 3)), content="3") // April

// Add with duration
let result = @date_fns.add(@date_fns.fromYMD(2024, 0, 1), days=5, months=1)
inspect(@date_fns.getMonth(result), content="1") // February
inspect(@date_fns.getDate(result), content="6")
```

## Getting/Setting Date Components

```mbt test
let date = @date_fns.fromYMD(2024, 5, 20)

// Get components
inspect(@date_fns.getYear(date), content="2024")
inspect(@date_fns.getMonth(date), content="5") // June (0-indexed)
inspect(@date_fns.getDate(date), content="20")

// Set components
let d1 = @date_fns.setYear(date, 2025)
inspect(@date_fns.getYear(d1), content="2025")
let d2 = @date_fns.setMonth(date, 0)
inspect(@date_fns.getMonth(d2), content="0") // January
let d3 = @date_fns.setDate(date, 1)
inspect(@date_fns.getDate(d3), content="1")
```

## Start/End of Periods

```mbt test
let date = @date_fns.fromYMD(2024, 0, 15) // January 15

// Start/end of month
let startMonth = @date_fns.startOfMonth(date)
let endMonth = @date_fns.endOfMonth(date)
inspect(@date_fns.getDate(startMonth), content="1")
inspect(@date_fns.getDate(endMonth), content="31") // January has 31 days
```

## Unix Timestamps

```mbt test
// Create date from Unix timestamp
let date = @date_fns.fromUnixTime(1704067200) // 2024-01-01 00:00:00 UTC
inspect(@date_fns.getYear(date), content="2024")

// Get Unix timestamp from date
let ts = @date_fns.getUnixTime(@date_fns.parseISO("2024-01-01T00:00:00Z"))
inspect(ts, content="1704067200")
```

## ISO Formatting

```mbt test
let date = @date_fns.fromYMD(2024, 0, 15)
let iso = @date_fns.formatISO(date)
inspect(iso.has_prefix("2024-01-15"), content="true")
```

## See Also

- [date-fns Documentation](https://date-fns.org/docs/)
