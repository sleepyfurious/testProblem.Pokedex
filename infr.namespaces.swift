/* 
 * This file encodes high-level namespaces for its parent project.
 *
 * Namespaces are commonly structured as hierarchies to allow reuse of names while adding intrinsic meaning to those
 * names in different contexts. Since symbol namespacing isn't one of the Swift 5 language features, enum is used to
 * structure namespaces whenever it can be applied straightforwardly as recommended by [1, 2]. However, there are cases
 * when some IDE features or other language features are incompatible with this way of namespacing. We can employ
 * workarounds:
 *
 * - When nested symbols can't be used (e.g. nested SwiftUI's PreviewProvider struct doesn't work with Xcode Preview
 *   Canvas), one can always use name prefixes in file scope or global scope to keep symbol names collision-free.
 *
 * - When relative references to nested symbols can't be made, type aliases or forms of delegation can be used to
 *   mitigate the need for absolute references.
 */

// MARK: === Application-Wide scope

// Assuming that coders should be familiar with these app-wide symbols and naming, these grouping are't done in type
// hierarchy to avoid unnecessary name resolution at client code. They are marked only with the prefix in their
// filename to make them stand out. Here is the list: 
//
// - app: A grouping for anythings those are concerned as Entry points, shared rich media assets, build-configurations
//   for this app.
//
// - infr: Application "infrastructure". A grouping for common types, properties, or functions used among different
//   parts of this app. 

// MARK: === The rest

/// Namespacing for user interfaces related code.
enum ui {}

/// Namespacing for problem domain's model of this app.
enum model {}  

// References:
// 1. The Power of Namespacing in Swift, Vadim Bulavin, published 2019:
//    https://www.vadimbulavin.com/the-power-of-namespacing-in-swift/
// 2. Learn the Four Swift Patterns I Swear By, Bart Jacobs, published 2017:
//    https://leanpub.com/learn-the-four-swift-patterns-i-swear-by
