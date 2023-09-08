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
Values that are consistent across applications should be defined by the Desktop environment Configuration, if not by the system itself.

Values that vary across applications should be defined in that application's yuck files. This allows aspects of that applications configuration to carry across mutliple instances.

Values specific to an application's session should be either defined in the application's json data or passed in as an argument when being instanced (the former is greatly preferred to the latter).

## Branding Guidelines
Developers are allowed to define their own styles for their app's UI, but are encouraged to allow the user to override it with the system theme through the use of a seperate stylesheet to define colors, sizes, etc., along with fallback values in the application's main stylesheet that pull from the system-defined theme.
