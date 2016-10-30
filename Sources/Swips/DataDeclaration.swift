/// A data declaration in the data section of a binary.
final class DataDeclaration {
    /// The underlying declaration that describes the data declared
    let kind: DataDeclarationKind
    
    /// The label on the declaration
    let label: String
    
    
    /// Creates a data declaration with the provided label and kind
    ///
    /// - Parameters:
    ///   - kind: The kind of declaration
    ///   - label: The label it will have in the assembly
    init(kind: DataDeclarationKind, label: String) {
        self.kind = kind
        self.label = label
    }
}
