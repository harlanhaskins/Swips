/// Serializes a MIPS program as an assembly string
struct ProgramSerializer {
    /// The program that will be serialized
    let program: Program
    
    /// Serializes an instruction with the correct MIPS syntax
    func serialize(_ instruction: Instruction) -> String {
        switch instruction {
        case .lw(let destination, let offset, let addr):
            return instr("lw", destination, "\(offset)(\(addr))")
        case .lb(let destination, let offset, let addr):
            return instr("lb", destination, "\(offset)(\(addr))")
        case .li(let reg, let imm):
            return instr("li", reg, imm)
        case .la(let reg, let decl):
            return instr("la", reg, decl.label)
        case .sw(let source, let offset, let addr):
            return instr("sw", source, "\(offset)(\(addr))")
        case .sb(let source, let offset, let addr):
            return instr("sb", source, "\(offset)(\(addr))")
        case .rtype(let name, let dst, let r1, let r2, let signed):
            let suffix = signed ? "" : "u"
            return instr("\(name)\(suffix)", dst, r1, r2)
        case .itype(let name, let dst, let r, let imm, let signed):
            let suffix = signed ? "" : "u"
            return instr("\(name)i\(suffix)", dst, r, imm)
        case .j(let block):
            return instr("j", block.label)
        case .jal(let block):
            return instr("jal", block.label)
        case .br(let cmp, let s, let t, let target):
            return instr("b\(cmp.rawValue)", s, t, target.label)
        case .jr(let reg):
            return instr("jr", reg)
        case .mult(let s, let t):
            return instr("mult", s, t)
        case .multu(let s, let t):
            return instr("multu", s, t)
        case .mfhi(let reg):
            return instr("mfhi", reg)
        case .mflo(let reg):
            return instr("mflo", reg)
        case .noop:
            return "noop"
        case .syscall:
            return "syscall"
        }
    }
    
    /// Serializes a basic block by serializing the instructions and label
    func serialize(_ basicBlock: BasicBlock) -> String {
        var instrText = basicBlock.instructions.map {
            "\t\t\(serialize($0))"
        }
        instrText.insert("\(basicBlock.label):", at: 0)
        if basicBlock.global {
            instrText.insert("\t\t.globl \(basicBlock.label)", at: 0)
        }
        return instrText.joined(separator: "\n")
    }
    
    /// Serializes a program by serializing the text and data sections
    func serialize(_ program: Program) -> String {
        var sections = [String]()
        if !program.blocks.isEmpty {
            let code = program.blocks.map(serialize).joined(separator: "\n")
            sections.append([
                "\t\t.text",
                "\t\t.align \(program.align)",
                code
            ].joined(separator: "\n"))
        }
        if !program.data.isEmpty {
            let code = program.data.map(serialize).joined(separator: "\n")
            sections.append("\t\t.data\n\(code)")
        }
        return sections.joined(separator: "\n\n")
    }
    
    /// Serializes the provided data declaration label and kind
    func serialize(_ dataDeclaration: DataDeclaration) -> String {
        return "\(dataDeclaration.label):\n\t\t\(serialize(dataDeclaration.kind))"
    }
    
    /// Serializes the provided data declaration kind as a MIPS assembly string
    func serialize(_ dataDeclarationKind: DataDeclarationKind) -> String {
        switch dataDeclarationKind {
        case .byte(let bytes):
            return ".byte \(commaSep(bytes))"
        case .word(let words):
            return ".word \(commaSep(words))"
        case .halfword(let halfwords):
            return ".halfword \(commaSep(halfwords))"
        case .ascii(let str, let terminated):
            let suffix = terminated ? "z" : ""
            return ".ascii\(suffix) \"\(str)\""
        case .space(let length):
            return ".space \(length)"
        }
    }
    
    /// Serializes a register
    func serialize(_ register: Register) -> String {
        return "\(register)"
    }
    
    /// Serializes the provided program
    func serialize() -> String {
        return serialize(program)
    }
}

fileprivate func commaSep(_ values: [Any]) -> String {
    return values.map { String(describing: $0) }.joined(separator: ", ")
}

fileprivate func instr(_ name: String, _ args: Any...) -> String {
    return "\(name)\t\t\(commaSep(Array(args)))"
}
