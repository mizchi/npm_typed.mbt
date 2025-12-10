# mizchi/npm_typed/zod

MoonBit bindings for [Zod](https://zod.dev/) - TypeScript-first schema validation with static type inference.

## Installation

```bash
moon add mizchi/js
moon add mizchi/npm_typed
npm install zod
```

Add to your `moon.pkg.json`:

```json
{
  "import": [
    "mizchi/js",
    "mizchi/js/core",
    "mizchi/npm_typed/zod"
  ]
}
```

## Limitations

Unlike TypeScript, MoonBit's current type system cannot infer types from Zod schemas at compile time. In TypeScript, you can do `z.infer<typeof schema>` to get static types, but this is not possible in MoonBit.

## Basic Usage

```mbt test
let str_schema = @zod.string()
let result = str_schema.safeParse(@core.any("hello"))
inspect(result is Ok(_), content="true")
let num_schema = @zod.number()
let result2 = num_schema.safeParse(@core.any(42))
inspect(result2 is Ok(_), content="true")
let bool_schema = @zod.boolean()
let result3 = bool_schema.safeParse(@core.any(true))
inspect(result3 is Ok(_), content="true")
```

## Object Schema

```mbt test
let user_schema = @zod.object({
  "name": @zod.string(),
  "age": @zod.number().int(),
  "email": @zod.string().email(),
})
let data = @core.new_object()
data["name"] = @core.any("Alice")
data["age"] = @core.any(30)
data["email"] = @core.any("alice@example.com")
inspect(user_schema.safeParse(data) is Ok(_), content="true")
```

## String Validations

```mbt test
// Email validation
let email_schema = @zod.string().email()
inspect(
  email_schema.safeParse(@core.any("test@example.com")) is Ok(_),
  content="true",
)
inspect(
  email_schema.safeParse(@core.any("not-an-email")) is Err(_),
  content="true",
)

// Length validation
let len_schema = @zod.string().min(2).max(5)
inspect(len_schema.safeParse(@core.any("abc")) is Ok(_), content="true")
inspect(len_schema.safeParse(@core.any("a")) is Err(_), content="true")
inspect(len_schema.safeParse(@core.any("abcdef")) is Err(_), content="true")

// URL validation
let url_schema = @zod.string().url()
inspect(
  url_schema.safeParse(@core.any("https://example.com")) is Ok(_),
  content="true",
)

// UUID validation
let uuid_schema = @zod.string().uuid()
inspect(
  uuid_schema.safeParse(@core.any("550e8400-e29b-41d4-a716-446655440000"))
  is Ok(_),
  content="true",
)
```

## Number Validations

```mbt test
// Integer only
let int_schema = @zod.number().int()
inspect(int_schema.safeParse(@core.any(42)) is Ok(_), content="true")

// Positive
let positive_schema = @zod.number().positive()
inspect(positive_schema.safeParse(@core.any(5)) is Ok(_), content="true")
inspect(positive_schema.safeParse(@core.any(-5)) is Err(_), content="true")

// Range constraints
let range_schema = @zod.number().gt(0).lte(100)
inspect(range_schema.safeParse(@core.any(50)) is Ok(_), content="true")
inspect(range_schema.safeParse(@core.any(0)) is Err(_), content="true")
inspect(range_schema.safeParse(@core.any(101)) is Err(_), content="true")
```

## Modifiers

```mbt test
// Optional - allows undefined
let optional_schema = @zod.string().optional()
inspect(optional_schema.safeParse(@core.any("hello")) is Ok(_), content="true")
inspect(optional_schema.safeParse(@core.undefined()) is Ok(_), content="true")

// Nullable - allows null
let nullable_schema = @zod.string().nullable()
inspect(nullable_schema.safeParse(@core.any("hello")) is Ok(_), content="true")
inspect(nullable_schema.safeParse(@core.null()) is Ok(_), content="true")

// Nullish - allows null or undefined
let nullish_schema = @zod.string().nullish()
inspect(nullish_schema.safeParse(@core.null()) is Ok(_), content="true")
inspect(nullish_schema.safeParse(@core.undefined()) is Ok(_), content="true")
```

## Array Schema

```mbt test
let schema = @zod.array(@zod.number())
let data = @zod.from_array([1, 2, 3])
inspect(schema.safeParse(data) is Ok(_), content="true")

// Nonempty array
let nonempty_schema = @zod.array(@zod.number()).nonempty()
inspect(
  nonempty_schema.safeParse(@zod.from_array([1])) is Ok(_),
  content="true",
)
let empty : Array[Int] = []
inspect(
  nonempty_schema.safeParse(@zod.from_array(empty)) is Err(_),
  content="true",
)
```

## Enum Schema

```mbt test
let schema = @zod.enum_(["red", "green", "blue"])
inspect(schema.safeParse(@core.any("red")) is Ok(_), content="true")
inspect(schema.safeParse(@core.any("yellow")) is Err(_), content="true")
```

## Union Schema

```mbt test
let schema = @zod.union([@zod.string(), @zod.number()])
inspect(schema.safeParse(@core.any("hello")) is Ok(_), content="true")
inspect(schema.safeParse(@core.any(42)) is Ok(_), content="true")
inspect(schema.safeParse(@core.any(true)) is Err(_), content="true")
```

## Transform

```mbt test
let schema = @zod.string().transform(fn(s) {
  let str : String = s.cast()
  @core.any(str.to_upper())
})
try schema.parse(@core.any("hello")) catch {
  _ => ()
} noraise {
  data => {
    let result : String = data.cast()
    inspect(result, content="HELLO")
  }
}
```

## Coercion

```mbt test
// Coerce number to string
let str_schema = @zod.coerce_string()
try str_schema.parse(@core.any(123)) catch {
  _ => ()
} noraise {
  data => {
    let result : String = data.cast()
    inspect(result, content="123")
  }
}

// Coerce string to number
let num_schema = @zod.coerce_number()
try num_schema.parse(@core.any("42")) catch {
  _ => ()
} noraise {
  data => {
    let result : Int = data.cast()
    inspect(result, content="42")
  }
}
```

## Custom Validation with Refine

```mbt test
let schema = @zod.string().refine(
  fn(val) {
    let s : String = val.cast()
    s.length() > 3
  },
  message="Must be longer than 3 characters",
)
inspect(schema.safeParse(@core.any("hello")) is Ok(_), content="true")
inspect(schema.safeParse(@core.any("hi")) is Err(_), content="true")
```

## Error Handling

```mbt test
let schema = @zod.string()
let result = schema.safeParse(@core.any(123))
match result {
  Ok(_) => ()
  Err(err) => {
    let issues = err.issuesArray()
    inspect(issues.length() > 0, content="true")
  }
}
```

## See Also

- [Zod Documentation](https://zod.dev/)
