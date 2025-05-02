<h1 align="center">SecuredCat</h1>
<h3 align="center">iOS app combining SwiftUI and UIKit for secure login and managing favorite cats</h3>

SecuredCat is an innovative iOS application that seamlessly blends **SwiftUI**'s declarative design with the precision of **UIKit**. Built with security and usability in mind, this app leverages **Keychain** (using SimpleKeychain) to securely manage user PINs. The app efficiently retrieves data from thecatapi.com using **Combine** for asynchronous operations, and it ensures that users' favorite cats are stored locally with **Core Data**. Seamless communication between SwiftUI and UIKit components is achieved through **UIViewControllerRepresentable**, resulting in a smooth and integrated user experience. SecuredCat supports **iOS 15 and later**, taking full advantage of the modern features available in these versions.


## Table of Contents
- [Technologies and Libraries](#technologies-and-libraries)
- [Configuration](#configuration)
- [Login Screen](#login-screen)
- [SwiftUI and UIKit Integration](#swiftui-and-uikit-integration)
- [Cat List](#cat-list)
- [Cat Details](#cat-details)
- [Favorites](#favorites)
- [Splash Screen](#splash-screen)
- [Additional info](#additional-info)



## Technologies and Libraries
- **[Swift](https://swift.org)**
- **[SwiftUI](https://developer.apple.com/xcode/swiftui/)**
- **[UIKit](https://developer.apple.com/documentation/uikit)**
- **[Combine](https://developer.apple.com/documentation/combine)**
- **[Core Data](https://developer.apple.com/documentation/coredata)**
- **[SimpleKeychain](https://github.com/auth0/SimpleKeychain)**
- **[UIViewControllerRepresentable](https://developer.apple.com/documentation/swiftui/uiviewcontrollerrepresentable)**
- **[The cat API](https://thecatapi.com)**



# Configuration
To check how the app works after cloning this repo, simply navigate to the `NetworkKey` file *(SecuredCat/Network/NetworkKey.swift)* and paste your API key.

<p align="center"> 
  <img src="https://github.com/user-attachments/assets/de85065b-a5dd-44cc-9c5d-d7d0c931e385">
</p>



## Login Screen
The application opens with a secure login screen that authenticates users either via a PIN or **FaceID**. If a PIN has not been set, the user is prompted to create one. The PIN is securely stored using the **Keychain** (via SimpleKeychain), and users have an option to reset it. A "Reset PIN" button is available at the bottom of the screen, allowing users to clear the stored PIN and any associated data from **Core Data**. The login interface, built with UIKit, features smooth animations for both failed and successful login attempts.

<p align="center"> 
  <img src="https://github.com/user-attachments/assets/0aa6a939-e9b8-457f-a3e3-018dcd8a5200">
  <img src="https://github.com/user-attachments/assets/0ab9033c-4972-456c-892b-79889494c895">
</p>



## SwiftUI and UIKit Integration
SecuredCat is a hybrid application that combines the strengths of both **SwiftUI** and **UIKit**. The initial login interface is developed using UIKit, ensuring robust security and smooth animations. Once a user logs in successfully, the main content is presented using SwiftUI views. UIKit components are seamlessly integrated into the SwiftUI experience through the use of **UIViewControllerRepresentable**, resulting in a unified and fluid user interface.




## Cat List
After authentication, users are greeted with a dynamic display of cat images along with relevant data. The cat list is designed using SwiftUI and fetches data from **thecatapi.com** through **Combine**. The interface is built to handle network errors gracefully by displaying an error message along with a button to attempt a retry. A search bar is provided, although it may be limited by API constraints, and a skeleton loading screen is shown while images load. The list is arranged in a lazy grid layout that supports pagination, preventing excessive data downloads and ensuring a smooth browsing experience.

<p align="center"> 
  <img src="https://github.com/user-attachments/assets/eef1cd7d-2907-431e-9ef2-5e6f3050bccc">
  <img src="https://github.com/user-attachments/assets/31eb1079-0e9d-4e43-8f47-26cd4b585d6a">
</p>




## Cat Details
Upon selecting a cat from the list, the app presents a detailed screen showing the cat’s image and additional information about its breed (if available). This screen not only allows users to view detailed data but also enables them to add or remove the cat from their Favorites list by tapping a heart icon. The design includes provisions for handling unexpected errors by offering a drag to refresh (like in the *Cat List*). Additionally, users can long-press on the image to share it or save it directly to their device, adding a layer of interactivity and convenience.

<p align="center"> 
  <img src="https://github.com/user-attachments/assets/c2988f8d-666a-482c-9be3-1012823dc5ab">
  <img src="https://github.com/user-attachments/assets/a2cd7790-feb2-4a2b-a5f4-d0ef5eb7ef76">
</p>



## Favorites
The application allows users to mark cat images as favorites. When the heart icon is tapped in the *Cat Details* screen, the selected cat is added to a Favorites list. This list is stored persistently using **Core Data**, ensuring that users can easily access their favorite cats at any time without data loss.

<p align="center"> 
  <img src="https://github.com/user-attachments/assets/3f65cba0-77f2-4c5d-95ec-105df1a0a7b0">
  <img src="https://github.com/user-attachments/assets/9cf2b4a1-d7dc-481c-9e24-86afe483480a">
</p>





## Splash Screen
Upon launching, the app displays a splash screen.

<p align="center"> 
  <img src="https://github.com/user-attachments/assets/3e688122-cc87-4912-b60a-e577cc7a18ae">
  <img src="https://github.com/user-attachments/assets/b819b33d-1265-4a02-a9a3-0559e2146285">
</p>




## Additional info
- SecuredCat follows best practices for network calls by using generics, making it easier to enhance the application's functionality.
- Custom errors are thrown to provide clear and user-friendly error messages.
- Important objects such as *CatService* are injected throughout the application to avoid creating duplicate instances.
- Navigation between screens—from the Splash Screen to the Login and Main View—is efficiently managed by a custom *NavCoordinator*, ensuring a consistent user flow throughout the app.

