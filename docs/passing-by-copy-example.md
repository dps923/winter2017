```
struct StructValueType {
    var x = 0
}

class ClassReferenceType {
    var x = 0
}

func modifyStruct(type: StructValueType) {
    var type = type
    type.x = 10
}
func modifyClass(type: ClassReferenceType) {
    var type = type
    type.x = 10
}

func modifyString(type: String) {
    var type = type
    type = "this doesn't change it"
}

var str = "original value"
var structType = StructValueType()
var classType = ClassReferenceType()

modifyStruct(type: structType)
modifyClass(type: classType)
modifyString(type: str)

print(structType.x)
print(classType.x)
print(str)

```
The output is
```
10
0
no value
```