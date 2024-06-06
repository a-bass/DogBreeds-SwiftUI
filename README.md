# DogBreeds-SwiftUI

DogBreeds is a small SwiftUI app for viewing and liking images of dog breeds from the API https://dog.ceo/dog-api/ and is a suggestion for an MVVM pattern approach together with SwiftData and loading states, where all views are initiated with viewmodels, which in turn use clients for network and storage communication, without the need for environment variables. The project is developed with Xcode 15.4 and targets iOS 17.5.

## MVVM
Viewmodels for the main views implement the protocol `LoadableViewModel` and the main views use the shared view `AsyncView` as a root object, that allows the views to utilize one of the states `.loading`, `.failed` or `.loaded`, which is defined in the enum `LoadingState`. The majority of the viewmodels are initiated with network and/or storage client instances created in the app's main entry point `DogBreedsApp`, and the viewmodels are also responsible for providing child/detail view models for list rows or grid items. 

## Network client
Since the dog-API only provides JSON structured as simple dictionaries and arrays, `Decodable` is only used for the root objects containing "message" and "status", whereby the provider decodes the results to `String` arrays/dictionaries. The protocol `HTTPDataDownloader` allows the response to be tested with unit tests, as well as to create mock data for SwiftUI previews.

## Storage client
Metadata for the images that are set to ”liked” is stored with SwiftData, introduced in iOS 17. To allow the client to be unit tested and used with SwiftUI previews, there is a mock `ModelConfiguration` only available for debug builds with the property `isStoredInMemoryOnly` set to `true`. Since the unit tests showed that changes were not autosaved quickly enough when an item was inserted and then deleted directly, each insert/delete is saved manually if the `ModelContext property` `hasChanges` is `true`. 

## Miscellaneous
- The `ContentUnavailableView` included with the iOS 17 release, is used when there are no likes to present in the list of the liked images page.

- Translations for English and Swedish are made with a string catalog and `String(localized:)` introduced in iOS 15, and are accessed through computed properties in the view models.

- `AsyncImage` which was introduced in iOS 15, is used with phases in a custom component, where it had to be embedded in a `VStack` to support accessibility.

- Support for accessibility with translated labels accessed through computed properties in the view models, and where larger groups of objects have been combined as a single `accessibilityElement`.

## Credits and inspiration
- https://dog.ceo
- https://www.hackingwithswift.com/quick-start/swiftdata/how-to-use-mvvm-to-separate-swiftdata-from-your-views
- https://www.swiftbysundell.com/articles/handling-loading-states-in-swiftui/
- https://swiftindepth.com/articles/swiftui-loading-states-with-mutation/
