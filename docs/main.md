## `json_multiquery`

```ab
pub fun json_multiquery(query: [Text], raw: Bool = false): [Text]? 
```

Perform multiple JSON queries and return as an array

## `json_parser`

```ab
pub fun json_parser(input: Text, raw: Bool = false): Null? 
```

Initialize internal JSON parser

Set `raw` to `false` to preserve quotes and escaped sequences

## `json_query`

```ab
pub fun json_query(query: Text, raw: Bool = false): Text? 
```

Perform a single JSON query

## `json_remove`

```ab
pub fun json_remove(key: Text): Null? 
```

Remove JSON key/element

## `json_set`

```ab
pub fun json_set(key: Text, value: Text): Null? 
```

Modify/append JSON key value/element
If `key` includes [], `value` is added as an element to `key` array

## `json_trim`

```ab
pub fun json_trim(input: Text, validate: Bool = false): Text? 
```

Trim JSON. Set `validate` to `false` for the best performance

## `key_to_arr`

```ab
pub fun key_to_arr(key: Text, raw: Bool = false): Null? 
```

Transform child key array/object to root array. Useful when you only iterate over its child keys/don't need parent keys

## `load_shelljq`

```ab
pub fun load_shelljq(path: Text): Null? 
```

## `throw_error`

```ab
fun throw_error(func: Text): Null? 
```

