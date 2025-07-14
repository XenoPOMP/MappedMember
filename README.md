## Mapped macro

This macro allows you to map class/struct attribute to another (auto-generated) one,
so you can, for example, create JSON-like structure with correct cased names.

## Installation
### Via SPM
Just use https://github.com/XenoPOMP/MappedMember.git to install it with Xcode
SPM tool.

## Usage

```swift
import MappedMember
import Foundation

struct Test {
    @Mapped("AGENCY_1") var agency: Int = 12
    
    // Should set auto-generated value, not mapped one. Because it can be
    // not available in the scope
    init(AGENCY_1: Int) {
        self.AGENCY_1 = AGENCY_1
    }
}

var test = Test(AGENCY_1: 12)
print("get test.agency = \(test.agency)") // 12

test.agency = 13
print("get test.agency = \(test.agency)") // 13

```
