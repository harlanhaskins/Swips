class Program {
    let align: Int
    var blocks = [BasicBlock]()
    
    init(align: Int = 2) {
        self.align = align
    }
    
    func add(_ basicBlock: BasicBlock) {
        blocks.append(basicBlock)
    }
    
    var assembly: String {
        let code = blocks.map {
            $0.assembly
            }.joined(separator: "\n")
        return [
            ".text",
            ".align \(align)"
            ].joined(separator: "\n") + "\n" + code
    }
}
