import MappedMember

struct Test: Codable {
    @Mapped("AGENCY_1") var agency: Int
}

class Test1: Codable {
    var test1: Int
    {
        get { self[keyPath: \._test1] }
        set { self[keyPath: \._test1] = newValue }
    }
    
    private var _test1: Int
    
    @Mapped("CODE_VM") var codeVM: Int
}
