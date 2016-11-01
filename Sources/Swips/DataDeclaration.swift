/// A data declaration in the data section of a binary.
final class DataDeclaration: TopLevelEntity {
    /// The label on the declaration
    let label: String
    
    /// The underlying declaration that describes the data declared
    let kind: DataDeclarationKind
    
    /// Creates a data declaration with the provided label and kind
    ///
    /// - Parameters:
    ///   - label: The label it will have in the assembly
    ///   - kind: The kind of declaration
    init(label: String, kind: DataDeclarationKind) {
        self.kind = kind
        self.label = label
    }
}
