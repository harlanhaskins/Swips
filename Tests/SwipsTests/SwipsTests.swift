import XCTest
@testable import Swips

class SwipsTests: XCTestCase {
    func testExample() {
        let prog = Program()
        let builder = InstructionBuilder(program: prog)
        
        let str = DataDeclaration(kind: .ascii("! = ", terminated: true),
                                   label: "fact_of")
        builder.build(str)
        
        builder.createBlock(name: "main", global: true, insert: true)
        builder.build(.li(.s0, 1))
        builder.build(.li(.s1, 10))
        builder.build(.add(.s2, .s1, .zero))
        
        let loopBB = builder.createBlock(name: "loop")
        let endBB = builder.createBlock(name: "end")
        
        builder.insertBlock = loopBB
        builder.build(.br(.eq, .s1, .zero, endBB))
        builder.build(.mult(.s0, .s1))
        builder.build(.mflo(.s0))
        builder.build(.addi(.s1, .s1, -1))
        builder.build(.j(loopBB))
        
        builder.insertBlock = endBB
        
        builder.build(.li(.v0, 1))
        builder.build(.add(.a0, .s2, .zero))
        builder.build(.syscall)
        
        builder.build(.li(.v0, 4))
        builder.build(.la(.a0, str))
        builder.build(.syscall)
        
        builder.build(.li(.v0, 1))
        builder.build(.add(.a0, .s0, .zero))
        builder.build(.syscall)
        
        builder.build(.li(.v0, 11))
        builder.build(.li(.a0, 10))
        builder.build(.syscall)
        
        builder.build(.li(.v0, 10))
        builder.build(.syscall)
        
        print(ProgramSerializer(program: prog).serialize())
    }


    static var allTests : [(String, (SwipsTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
