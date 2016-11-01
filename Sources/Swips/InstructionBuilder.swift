final class InstructionBuilder {
    var insertBlock: BasicBlock?
    let program: Program
    
    init(program: Program) {
        self.program = program
    }
    
    @discardableResult
    func createBlock(name: String, global: Bool = false, insert: Bool = false) -> BasicBlock {
        let block = BasicBlock(label: name, global: global)
        program.add(block)
        if insert {
            insertBlock = block
        }
        return block
    }
    
    @discardableResult
    func createData(name: String, kind: DataDeclarationKind) -> DataDeclaration {
        let data = DataDeclaration(label: name, kind: kind)
        program.add(data)
        return data
    }
    
    func build(_ instruction: Instruction) {
        guard let block = insertBlock else {
            fatalError("must set insert block before building")
        }
        block.add(instruction)
    }
}
