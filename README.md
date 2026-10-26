# json.ab
First JSON parser for Amber

Under the hood it uses [shelljq](https://github.com/Tirito6626/shelljq) as the parsing and validating engine, 
acting more like a wrapper for two main reasons:
- Amber sacrifices performance for safety, which adds up expotentially to the total execution time
- Making own JSON parser is simply insane. Since Amber is a transpiler, it's simply not worth trying to reinvent the bycicle with extra steps for the better look, at least at the moment

## Installation
Simply clone this repository. It *should* automatically clone `shelljq` as submodule.

## Usage
You can import all functions from the `main.ab` file:

```ab
import { json_query } from "path/to/json.ab/main.ab"
```

## Documentation
See `docs/main.md` for functions documentation.
