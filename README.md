# cheddar-braces

A simple script checking whether a string is balanced.

## Usage

```
bin/check_balance '([([[(]])])'
```

You can also pass several strings at once:

```
bin/check_balance '()', '[]', '(()'
```

A string is balanced if it has a closing bracket/brace for each opening bracket/brace.

Examples of balanced strings:
```
bin/check_balance '()', '[]', '[([(([()]))])]', ''
```

Examples of imbalanced strings:
```
bin/check_balance '(', ']', '(()', '][', '([)]'
```
