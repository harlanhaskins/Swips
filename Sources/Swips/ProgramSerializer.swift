struct ProgramSerializer {
    let program: Program
    
    func serialize(_ instruction: Instruction) -> String {
        switch instruction {
        case .lw(let destination, let offset, let addr):
            return "lw\t\t\(destination), \(offset)(\(addr))"
        case .lb(let destination, let offset, let addr):
            return "lb\t\t\(destination), \(offset)(\(addr))"
        case .li(let reg, let imm):
            return "li\t\t\(reg), \(imm)"
        case .la(let reg, let decl):
            return "la\t\t\(reg), \(decl.label)"
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
    
    func serialize(_ dataDeclaration: DataDeclaration) -> String {
        return "\(dataDeclaration.label):\n\t\t\(serialize(dataDeclaration.kind))"
    }
    
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
    
    func serialize(_ register: Register) -> String {
        return "\(register)"
    }
    
    func serialize() -> String {
        return serialize(program)
    }
}

fileprivate func commaSep(_ values: [Any]) -> String {
    return values.map { String(describing: $0) }.joined(separator: ", ")
}
