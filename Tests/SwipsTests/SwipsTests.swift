import XCTest
@testable import Swips

class SwipsTests: XCTestCase {
    func testExample() {
        let prog = Program()
        let builder = InstructionBuilder(program: prog)
        
        builder.createBlock(name: "main", global: true, insert: true)
        builder.build(.li(.s0, 1))
        builder.build(.li(.s1, 10))
        
        let loopBB = builder.createBlock(name: "loop")
        let endBB = builder.createBlock(name: "end")
        
        builder.insertBlock = loopBB
        builder.build(.br(.eq, .s1, .zero, endBB))
        builder.build(.mult(.s0, .s1))
        builder.build(.mflo(.s0))
        builder.build(.addi(.s1, .s1, -1))
        builder.build(.j(loopBB))
        
        builder.insertBlock = endBB
        builder.build(.addi(.v0, .zero, 1))
        builder.build(.add(.a0, .s0, .zero))
        builder.build(.syscall)
        
        builder.build(.li(.v0, 10))
        builder.build(.syscall)
        
        print(prog.assembly)
    }


    static var allTests : [(String, (SwipsTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
