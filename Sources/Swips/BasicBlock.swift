class BasicBlock {
    let label: String
    let global: Bool
    var instructions: [Instruction]
    
    init(label: String, global: Bool = false, instructions: [Instruction] = []) {
        self.label = label
        self.instructions = instructions
        self.global = global
    }
    
    func add(_ instruction: Instruction) {
        instructions.append(instruction)
    }
    
    var assembly: String {
        var instrText = instructions.map {
            "\t\t\($0.assembly)"
        }
        instrText.insert("\(label):", at: 0)
        if global {
            instrText.insert(".globl \(label)", at: 0)
        }
        return instrText.joined(separator: "\n")
    }
}
