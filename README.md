<h1 align="center">SecuredCats (in progress...)</h1>
<h3 align="center">iOS app combining SwiftUI and UIKit for secure login and managing favorite cats</h3>

SecuredCats is an innovative iOS application that seamlessly blends **SwiftUI**'s declarative design with the precision of **UIKit**. Built with security and usability in mind, this app leverages **Keychain** (using SimpleKeychain) to securely manage user PINs, while employing **Combine** to fetch data asynchronously from thecatapi.com. Local persistence of users’ favorite cats is ensured through **Core Data**, and both SwiftUI and UIKit components communicate via **UIViewRepresentable** for smooth integration.

## Table of Contents
- [Technologies and Libraries](#technologies-and-libraries)
- [Login Screen](#login-screen)
- [SwiftUI and UIKit Integration](#swiftui-and-uikit-integration)
- [Cat List](#cat-list)
- [Favorites](#favorites)



## Technologies and Libraries
- **[Swift](https://swift.org)**
- **[SwiftUI](https://developer.apple.com/xcode/swiftui/)**
- **[UIKit](https://developer.apple.com/documentation/uikit)**
- **[Combine](https://developer.apple.com/documentation/combine)**
- **[Core Data](https://developer.apple.com/documentation/coredata)**
- **[SimpleKeychain](https://github.com/auth0/SimpleKeychain)**
- **[UIViewRepresentable](https://developer.apple.com/documentation/swiftui/uiviewrepresentable)**
- **[The cat API](https://thecatapi.com)**



## Login Screen
The app opens with a secure login screen, where:
- Users authenticate themselves using a **PIN**.
- The PIN is securely stored in the **Keychain** using SimpleKeychain.
- If no PIN is set, the app prompts the user to create one.
- A **Reset PIN** button is available at the bottom of the screen to allow users to clear the stored PIN.
- The login screen is built with **UIKit**.



## SwiftUI and UIKit Integration
SecuredCats is a hybrid application that leverages the strengths of both **SwiftUI** and **UIKit**:
- The initial login interface is developed using UIKit.
- After a successful login, the main content is displayed as SwiftUI views.
- **UIViewRepresentable** is used to embed UIKit components into SwiftUI.




## Cat List
Once authenticated, users are greeted with a dynamic list of cat images and related data:
- Data is fetched from **thecatapi.com** using **Combine**.
- The list is designed with SwiftUI.
- Users can effortlessly browse through the list, with smooth transitions and pull-to-refresh functionality.



## Favorites
Users can mark their preferred cat images as favorites:
- Tapping on a heart adds it to the Favorites list.
- These favorites are persistently stored using **Core Data**.
- Visual feedback, such as simple animations, enhances the experience when adding or removing favorites.



