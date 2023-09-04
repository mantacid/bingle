# Why does this directory Exist?
While native apps are associated not with windows, but with tabs, it is still a good idea to define the basic widgets here, so that one can use them as a template from which to build the tab's data JSON and/or to load via the json so that the widget can then *call* the same json to get the data it needs. To dynamically generate the app yuck within the json would be a development nightmare, both for us and anyone wanting to customize the layouts of these applications.

# `programs/`
This Directory contains yuck used to render various applications and GUIs. Each application gets their own directory, which may optionally also contain stylesheets (to preserve branding, for example). The app directories should also contain any scripts they need to function.

## `manifest.yuck`
Serves to document all application yuck the system should be aware of (to render in an app menu for example). May get switched out for a `.json` format later.
