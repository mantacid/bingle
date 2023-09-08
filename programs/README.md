# Why does this directory Exist?
While native apps are associated not with windows, but with tabs, it is still a good idea to define the basic widgets here, so that one can use them as a template from which to build the tab's data JSON and/or to load via the json so that the widget can then *call* the same json to get the data it needs. To dynamically generate the app yuck within the json would be a development nightmare, both for us and anyone wanting to customize the layouts of these applications.

# `programs/`
This Directory contains yuck used to render various applications and GUIs. Each application gets their own directory, which may optionally also contain stylesheets (to preserve branding, for example). The app directories should also contain any scripts they need to function.

## `manifest.yuck`
Serves to document all application yuck the system should be aware of (to render in an app menu for example). May get switched out for a `.json` format later.

---

# Application Development Guidelines
In order for applications to be tied to their tabs, they need to adhere to a standard by which their data can be transimitted and stored. This standard is currently in development, but some basics will be outlined below:

## Application Data Standards
### User Data
**It is best practice to not have to handle/share sensetive user data**.
A good rule of thumb to remember: if the application does not require certain information to function properly, then *do not collect that information*. This includes anonymous diagnostics, which if provided **must be disabled by default**.

Developers are **heavily discouraged** from making core features of their application dependant upon the collection of user data when they do not need to be.

### Application Data
Values that are consistent across applications should be defined by the Desktop environment Configuration, if not by the system itself.

Values that vary across applications should be defined in that application's yuck files. This allows aspects of that applications configuration to carry across mutliple instances.

Values specific to an application's session should be either defined in the application's json data or passed in as an argument when being instanced (the former is greatly preferred to the latter).

# Application Design Guidelines
Your application needs to be usable for all people.

## Accessibility
**All applications should be accessible to all users.**
Accessibility programs such as screen readers, screen magnifiers, and mouse-aides should work well with the application, providing accurate and relevant information to the user employing these tools.

The desktop environment itself will provide global settings that developers can use to allow applications to adapt to a user's needs. However, one shouldn't rely on these settings always being available, as mistakes happen and settings could be misconfigured. The best practice is to make your applications accessible by default.

### Fonts
Fonts and their sizes are encouraged to use the system-defined values. If an application's branding uses a different font, the developer can use them, but they **must** allow these fonts to be overwritten by the user/system.

### Colors & Animations
Developers are **encouraged** to use colors and animations that do not cause eyestrain for users. Likewise, developers should **avoid** the use of flashing/strobing lights and animations in their UI. If there are such animations, the application **must**  respect any system settings that indicate that the user prefers reduced motion / non-straining colors.

---

## Branding Guidelines
Developers are allowed to define their own styles for their app's UI, but are **required** to allow the user to override it with the system theme through the use of a seperate stylesheet to define colors, sizes, etc., along with fallback values in the application's main stylesheet that pull from the system-defined theme. This allows users to use their own high-contrast themes & legible fonts for better accessibility.
