final class Program {
    let align: Int
    var blocks = [BasicBlock]()
    var data = [DataDeclaration]()
    
    init(align: Int = 2) {
        self.align = align
    }
    
    func add(_ basicBlock: BasicBlock) {
        blocks.append(basicBlock)
    }
    
    func add(_ dataDeclaration: DataDeclaration) {
        data.append(dataDeclaration)
    }
}
