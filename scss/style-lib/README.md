# `style-lib/`
This is where any useful scss functions, mixins, and effects get placed. This is NOT for files that help *parse* scss for inclusion in the configuration.

## `3D_FX.scss`
Defines a mixin, `pop_area`, that creates the illusion of a raised/inset area of the UI.

### Arguments
- `$dist` (number): the height (or depth, if the value is negative) that the area is displaced. Values in units of `px` or `em` are recommended.
- `$bg` (color): the background color of the element the mixin is being applied to.
- `$light` (color): the color to mix with the base when creating the highlights.
- `$shade` (color): the color to mix in with the base when creating the shadows
- `$intensity` (percent): how strong the effect should be. A value of 100% will completely replace the base color with the light/shade color, while a value of 0% will produce no effect.
- `$contrast` (float): dictates the difference between the primary and secondary highlights/shadows (currently this value also affects the intensity; this will change in the future.)
