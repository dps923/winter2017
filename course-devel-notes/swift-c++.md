# Variables
* Assignment vs. Declaration
* Mutable vs. Immutable (i.e. Constants)

C++
```
int x = 10;
x += 1;
const float pi = 3.1416f;
```
Swift
```
var x: Int = 10
x += 1
let pi: Float = 3.1416
```

## Basic Types
* Basic Types: `Int`, `String`, `Character`, `Bool`, `Float`, `Double`
* Type annotation and type inference

C++
```
auto x = 10; // infers type as int
const auto pi = 3.1416; // infers type as double (not float)
```

Swift
```
var x = 10 // infers the type as Int
let pi = 3.1416 // infers the type as Double (not Float)
```

## Strings
* Character, Escape character/sequence, and Unicode 
* String interpolation

C++
```
const char* name = "Sally";
printf("string length: %d", strlen(name));
// or
std::string nameSTL = "Sally";
printf("string length: %d", name.length());

std::string multibyte = "èèè";
printf("string length: %d", multibyte.length()); // outputs length of 6

```

Swift
```
let name = "Sally" // NOTE: could also write 'let name: String'
print("The string with value: \(name) has length: \(name.characters.count)")

let multibyte = "èèè"
print("correctly has \(multibyte.characters.length), yay for swift!") 
```

## Built-in Collection Types
* `Array`
* `Dictionary`
* Literals: `[]` and `[:]`
* Inferred and explicit typing of collections
* Indexing
* Adding values, changing values

C++
```
std::vector<std::string> cities = {"Toronto", "Montreal", "Ottawa"};
for (int i = 0; i < cities.count; i++) {
    std::cout << cities[i] << std::endl;    
} 
// or
for (auto city : cities) {
    std::cout << city << std::endl;
}

cities.push_back("Vancouver");
```

Swift
```
let cities = ["Toronto", "Montreal", "Ottawa"]
for city in cities {
    print(city)
}
// or
for i in 0..<cities.count {
    print(cities[i])
}

cities.append("Vancouver")
```



## Tuples
* Passing around groups of values

## Optionals
* Operators `?` and `!`
* Checking for `nil`
* Unwrapping optionals
* Unwrapping shorthand using `let`

# Conditionals
* if/else statement 
* switch statement and Enum type
* ternary operator

#  Looping
* C-style for loop vs. Swift `for..in` operator
* `while` loop
* Looping using
<br>- iteration type
<br>- `Range` type (open and closed)
<br>- `Stride`
<br>- `reverse()`
<br>- `filter` and `map`

# Functions
* Arguments, Argument labels
* Parameters, Return Types
* Closures

# Classes and Structs
* Initializer and `super`
* Method
* Property
* Pass by copy (Struct) vs reference (Class)
