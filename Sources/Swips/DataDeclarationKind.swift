/// Represents the base kind of a data declaration in MIPS.
enum DataDeclarationKind {
    
    /// A continguous number of bytes
    case byte([Int8])
    
    /// A contiguous number of half-words
    case halfword([Int16])
    
    /// A contiguous number of words
    case word([Int32])
    
    /// An ASCII string, optionally terminated with a null terminator
    case ascii(String, terminated: Bool)
    
    /// A number of bytes reserved in the binary
    case space(Int)
}
