# Ruby [JSON:API](http://jsonapi.org) library benchmarks

### Test 1
Goal: Try to have the jsonapi document match up as much as possible.

##### iterations per second
```
Comparison:
  fast_jsonapi eager:      518.3 i/s
  jsonapi-rb   eager:      452.7 i/s - 1.14x  (± 0.01) slower
  ams          eager:      216.6 i/s - 2.39x  (± 0.02) slower
                   with 95.0% confidence

```

##### memory allocation
```
Comparison:
  fast_jsonapi eager:      96234 allocated
  jsonapi-rb   eager:     126578 allocated - 1.32x more
  ams          eager:     245862 allocated - 2.55x more
```

### Test 2
Goal: see how things perform against defaults.

##### iterations per second
```
Comparison:
  fast_jsonapi eager:      547.9 i/s
  jsonapi-rb   eager:      521.4 i/s - 1.05x  (± 0.01) slower
  ams          eager:      219.0 i/s - 2.50x  (± 0.02) slower
                   with 95.0% confidence
```

##### memory allocation
```
Comparison:
  fast_jsonapi eager:      96234 allocated
  jsonapi-rb   eager:     109874 allocated - 1.14x more
  ams          eager:     249662 allocated - 2.59x more
```

# Overall Notes:
- at the time of writing this, netflix doesn't support:
  - nested includes.......
    - (so testing n+1 db-hit rendering can't happen)
  - relationship types aren't the same as the resource type...
  - _not_ rendering every id in a has_many relationship...
   by default, this means that jsonapi-rb is a clear winner...
