import MappedMember
import Foundation

struct Test {
    @Mapped("AGENCY_1") var agency: Int = 12
    
    init(AGENCY_1: Int) {
        self.AGENCY_1 = AGENCY_1
    }
}

var test = Test(AGENCY_1: 12)
print("get test.agency = \(test.agency)")

test.agency = 13
print("get test.agency = \(test.agency)")
