
enum Comparison: String {
    case lt, le, gt, ge, eq, ne
}

enum Instruction {
    case lw(destination: Register, offset: Int, addr: Register)
    case lb(destination: Register, offset: Int, addr: Register)
    case li(Register, Int)
    case sw(source: Register, offset: Int, addr: Register)
    case sb(source: Register, offset: Int, addr: Register)
    case rtype(String, Register, Register, Register, signed: Bool)
    case itype(String, Register, Register, Int, signed: Bool)
    case br(Comparison, Register, Register, BasicBlock)
    case j(BasicBlock)
    case jal(BasicBlock)
    case jr(Register)
    case mfhi(Register)
    case mflo(Register)
    case mult(Register, Register)
    case multu(Register, Register)
    case noop
    case syscall
    
    static func add(_ d: Register, _ s: Register, _ t: Register) -> Instruction {
        return .rtype("add", d, s, t, signed: true)
    }
    
    static func addu(_ d: Register, _ s: Register, _ t: Register) -> Instruction {
        return .rtype("add", d, s, t, signed: false)
    }
    
    static func addi(_ d: Register, _ s: Register, _ t: Int) -> Instruction {
        return .itype("add", d, s, t, signed: true)
    }
    
    static func addiu(_ d: Register, _ s: Register, _ t: Int) -> Instruction {
        return .itype("add", d, s, t, signed: false)
    }
    
    static func and(_ d: Register, _ s: Register, _ t: Register) -> Instruction {
        return .rtype("and", d, s, t, signed: true)
    }
    
    static func andi(_ d: Register, _ s: Register, _ t: Int) -> Instruction {
        return .itype("and", d, s, t, signed: true)
    }
    
    static func sub(_ d: Register, _ s: Register, _ t: Register) -> Instruction {
        return .rtype("sub", d, s, t, signed: true)
    }
    
    static func subu(_ d: Register, _ s: Register, _ t: Register) -> Instruction {
        return .rtype("sub", d, s, t, signed: false)
    }
    
    static func or(_ d: Register, _ s: Register, _ t: Register) -> Instruction {
        return .rtype("or", d, s, t, signed: true)
    }
    
    static func ori(_ d: Register, _ s: Register, _ t: Int) -> Instruction {
        return .itype("or", d, s, t, signed: true)
    }
    
    static func xor(_ d: Register, _ s: Register, _ t: Register) -> Instruction {
        return .rtype("xor", d, s, t, signed: true)
    }
    
    static func xori(_ d: Register, _ s: Register, _ t: Int) -> Instruction {
        return .itype("xor", d, s, t, signed: true)
    }
    
    static func div(_ d: Register, _ s: Register, _ t: Register) -> Instruction {
        return .rtype("div", d, s, t, signed: true)
    }
    
    static func divu(_ d: Register, _ s: Register, _ t: Register) -> Instruction {
        return .rtype("div", d, s, t, signed: false)
    }
    
    static func slt(_ d: Register, _ s: Register, _ t: Register) -> Instruction {
        return .rtype("slt", d, s, t, signed: true)
    }
    
    static func slti(_ d: Register, _ s: Register, _ t: Int) -> Instruction {
        return .itype("slt", d, s, t, signed: true)
    }
    
    static func sltu(_ d: Register, _ s: Register, _ t: Register) -> Instruction {
        return .rtype("slt", d, s, t, signed: false)
    }
    
    static func sltiu(_ d: Register, _ s: Register, _ t: Int) -> Instruction {
        return .itype("slt", d, s, t, signed: false)
    }
    
    var assembly: String {
        switch self {
        case .lw(let destination, let offset, let addr):
            return "lw\t\t\(destination), \(offset)(\(addr))"
        case .lb(let destination, let offset, let addr):
            return "lb\t\t\(destination), \(offset)(\(addr))"
        case .li(let reg, let imm):
            return "li\t\t\(reg), \(imm)"
        case .sw(let source, let offset, let addr):
            return "sw\t\t\(source), \(offset)(\(addr))"
        case .sb(let source, let offset, let addr):
            return "sb\t\t\(source), \(offset)(\(addr))"
        case .rtype(let name, let dst, let r1, let r2, let signed):
            let suffix = signed ? "" : "u"
            return "\(name)\(suffix)\t\t\(dst), \(r1), \(r2)"
        case .itype(let name, let dst, let r, let imm, let signed):
            let suffix = signed ? "" : "u"
            return "\(name)i\(suffix)\t\t\(dst), \(r), \(imm)"
        case .j(let block):
            return "j\t\t\(block.label)"
        case .jal(let block):
            return "jal\t\t\(block.label)"
        case .br(let cmp, let s, let t, let target):
            return "b\(cmp.rawValue)\t\t\(s), \(t), \(target.label)"
        case .jr(let reg):
            return "jr\t\t\(reg)"
        case .mult(let s, let t):
            return "mult\t\t\(s), \(t)"
        case .multu(let s, let t):
            return "multu\t\t\(s), \(t)"
        case .mfhi(let reg):
            return "mfhi\t\t\(reg)"
        case .mflo(let reg):
            return "mflo\t\t\(reg)"
        case .noop:
            return "noop"
        case .syscall:
            return "syscall"
        }
    }
}
