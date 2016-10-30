final class BasicBlock {
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
}
