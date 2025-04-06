# Komorebi Application-Specific Configuration

The Komorebi Application-Specific Configuration (ASC) was originally created as
a community-driven repository for users to share application-specific
[komorebi](https://github.com/LGUG2Z/komorebi) configuration options, with the
goal of creating a tiling window management experience on Windows that "just
works" for as many applications as possible.

As komorebi has grown in popularity, the vast majority of the most popular
Windows applications have come to be covered in this repository, and these
configuration options have even come to be used in [other
projects](https://dalyisaac.github.io/Whim/script/core/filtering.html?q=komorebi#built-in-filters).

## Schema

### v1

The first version of the ASC was `applications.yaml`. The schema for v1 was
created long before komorebi had support for different matching strategies or
composite rules.

v1 is considered deprecated as of 01 November 2024 and no further changes will
be accepted. However, the file will remain in this repository to ensure that
nothing breaks for existing users who might rely on the existence of the file in
this repository.

### v2

The second version of the ASC is `applications.json`. It will be the default
format from `komorebi` v0.1.30 onwards. The schema for v2 takes into account how
`komorebi.json`'s schema has evolved and aims to make it as easy as possible for
window and application matching rules to be copied and pasted from one file to
the other.

There is a [JSON
Schema](https://github.com/LGUG2Z/komorebi/blob/master/schema.asc.json)
definition available for v2 that can be generated using the `komorebic
application-specific-configuration-schema` command, which is used to power
auto-completions.

The v2 schema allows use of the full range of matching strategies and composite
rules to identify application windows. The full range of application rules that
can be applied are:

- `ignore` - Rules to ignore specific windows
- `manage` - Rules to forcibly manage specific windows
- `floating` - Rules to manage specific windows as floating windows (komorebi v0.1.30+)
- `transparency_ignore` - Rules to ignore specific windows from the transparency feature
- `tray_and_multi_window` - Rules to identify applications which minimize to the tray or have multiple windows
- `layered` - Rules to identify applications which have the `WS_EX_LAYERED` Extended Window Style
- `object_name_change` - Rules to identify applications which send the `EVENT_OBJECT_NAMECHANGE` event on launch
- `slow_application` - Rules to identify applications which are slow to send initial event notifications

#### Should I use a `floating` rule or an `ignore` rule?

You should use `ignore` rules when:

- Targeting a ghost window
- Targeting a popup which only exists to be immediately clicked away (confirmations etc.)

You should use `floating` rules when:

- Targeting a popup or a popout window which is interacted with for a while before being closed
- Targeting a popup or a popout window which is proactively toggled by the user for interaction

Windows targeted with `ignore` rules will not be managed at all by komorebi. In
practice, this means if you leave these windows open, they will be visible on
all komorebi workspaces, because komorebi is never touching them.

Windows targeted with `floating` rules will be managed by komorebi and scoped to
the workspace they are launched on or moved to.

## Contributing

If you would like to propose a new application configuration rule for
consideration, please open an issue with the rules you are proposing in a code
block rather than a PR.

When submitting a PR, make sure you have `jq` and `just` installed, and run
`just sort` to ensure that all entries in `applications.json` are sorted
correctly.

## FAQs

### I am a new komorebi user and I want to add different rules for various applications

Do not edit the `applications.json` or `applications.yaml` file; edit your
`komorebi.json` file instead.

Changes to the `applications.[yaml|json]` files are not hot-reloaded and applied,
and any changes you make will get blown away the next time you run `komorebic
fetch-app-specific-configuration` to fetch the latest version.

### I am a komorebi user and this repo floats an application which I want to be tiled

Do not submit a PR to this repo; to guarantee backwards compatibility for all
consumers of this repository, it is incredibly unlikely that such a PR will be
accepted.

You should add a force manage rule in your `komorebi.json` file, which will
override the float rule in this repository. Refer to the [Force Manage
Windows](https://lgug2z.github.io/komorebi/common-workflows/force-manage-windows.html)
tutorial on the documentation website.

### I am a komorebi user and I want to add an ignore rule for an application

You should add the ignore rule in your `komorebi.json` file. Refer to the
[Ignore Windows](https://lgug2z.github.io/komorebi/common-workflows/ignore-windows.html)
tutorial on the documentation website.

If you believe that this is a rule which should be set as default for all users,
please open an issue and explain your rationale.

### I am a komorebi user and I want to add a manage rule for an application

You should add the manage rule in your `komorebi.json` file. Refer to the
[Force Manage Windows](https://lgug2z.github.io/komorebi/common-workflows/force-manage-windows.html)
tutorial on the documentation website.

If you believe that this is a rule which should be set as default for all users,
please open an issue and explain your rationale.

### I am a komorebi user and I want to identify an application which minimizes to the tray or has multiple windows

You should add the tray and multi-window application rule in your
`komorebi.json` file. Refer to the
[Tray and Multi-Window Applications](https://lgug2z.github.io/komorebi/common-workflows/tray-and-multi-window-applications.html)
tutorial on the documentation website.

If you believe that this is a rule which should be set as default for all users,
please open an issue and explain your rationale.
