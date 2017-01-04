```
import Foundation

struct ByValueType {
    var x: Int = 0;
}

class ByReferenceType {
    var x: Int = 0;
}

var str: String = "no value";
var byRef: ByReferenceType = ByReferenceType();
var byVal: ByValueType = ByValueType();

func foo(var type: ByValueType) {
    type.x = 10;
}
func foo(var type: ByReferenceType) {
    type.x = 10;
}

func foo(var type: String) {
    type = "foo was here";
}

foo(byRef);
foo(byVal);
foo(str);

print(byRef.x);
print(byVal.x);
print(str);

```
The output is
```
10
0
no value
```