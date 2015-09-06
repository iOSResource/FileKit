//
//  FKOperators.swift
//  FileKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Nikolai Vazquez
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

// MARK: - FKFileType

infix operator |> {}
infix operator <| {}

/// Writes a string to a text file.
///
/// - Throws: `FKError.WriteToFileFail`
///
public func |> (data: String, file: FKTextFile) throws {
    try file.write(data)
}



// MARK: - FKTextFile

infix operator |>> {}

/// Appends a string to a text file.
///
/// - Throws: `FKError.ReadFromFileFail`, `FKError.WriteToFileFail`
///
public func |>> (data: String, file: FKTextFile) throws {
    let contents = try file.read()
    try contents + "\n" + data |> file
}



// MARK: - FKPath

@warn_unused_result public func == (lhs: FKPath, rhs: FKPath) -> Bool {
    return lhs.standardized.rawValue == rhs.standardized.rawValue
}

/// Concatenates two `FKPath` instances and returns the result.
///
///     let systemLibrary: FKPath = "/System/Library"
///     print(systemLib + "Fonts")  // "/System/Library/Fonts"
///
public func + (lhs: FKPath, rhs: FKPath) -> FKPath {
    switch (lhs.rawValue.hasSuffix(FKPath.Separator), rhs.rawValue.hasPrefix(FKPath.Separator)) {
    case (true, true):
        return FKPath("\(lhs.rawValue)\(rhs.rawValue.substringFromIndex(rhs.rawValue.startIndex.successor()))")
    case (false, false):
        return FKPath("\(lhs.rawValue)\(FKPath.Separator)\(rhs.rawValue)")
    default:
        return FKPath("\(lhs.rawValue)\(rhs.rawValue)")
    }
}

public func += (inout lhs: FKPath, rhs: FKPath) {
    lhs = lhs + rhs
}


postfix operator • {}

/// Returns the standardized version of the path.
@warn_unused_result public postfix func • (path: FKPath) -> FKPath {
    return path.standardized
}


postfix operator ^ {}

/// Returns the path's parent path.
@warn_unused_result public postfix func ^ (path: FKPath) -> FKPath {
    return path.parent
}


