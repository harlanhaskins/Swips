/// Represents one of the 32 MIPS registers
struct Register: CustomStringConvertible {
    /// The colloquial name of the register
    let name: String
    
    /// The register number
    let number: Int8
    
    /// Creates a reference to the register with a leading `$`
    var description: String {
        return "$\(name)"
    }
    
    static let zero = Register(name: "zero", number: 0)
    static let at = Register(name: "at", number: 1)
    static let v0 = Register(name: "v0", number: 2)
    static let v1 = Register(name: "v1", number: 3)
    static let a0 = Register(name: "a0", number: 4)
    static let a1 = Register(name: "a1", number: 5)
    static let a2 = Register(name: "a2", number: 6)
    static let a3 = Register(name: "a3", number: 7)
    static let t0 = Register(name: "t0", number: 8)
    static let t1 = Register(name: "t1", number: 9)
    static let t2 = Register(name: "t2", number: 10)
    static let t3 = Register(name: "t3", number: 11)
    static let t4 = Register(name: "t4", number: 12)
    static let t5 = Register(name: "t5", number: 13)
    static let t6 = Register(name: "t6", number: 14)
    static let t7 = Register(name: "t7", number: 15)
    static let s0 = Register(name: "s0", number: 16)
    static let s1 = Register(name: "s1", number: 17)
    static let s2 = Register(name: "s2", number: 18)
    static let s3 = Register(name: "s3", number: 19)
    static let s4 = Register(name: "s4", number: 20)
    static let s5 = Register(name: "s5", number: 21)
    static let s6 = Register(name: "s6", number: 22)
    static let s7 = Register(name: "s7", number: 23)
    static let t8 = Register(name: "t8", number: 24)
    static let t9 = Register(name: "t9", number: 25)
    static let k0 = Register(name: "k0", number: 26)
    static let k1 = Register(name: "k1", number: 27)
    static let gp = Register(name: "gp", number: 28)
    static let sp = Register(name: "sp", number: 29)
    static let fp = Register(name: "fp", number: 30)
    static let ra = Register(name: "ra", number: 31)
}
