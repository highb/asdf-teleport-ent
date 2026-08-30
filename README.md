<div align="center">

# asdf-teleport-ent [![Build](https://github.com/highb/asdf-teleport-ent/actions/workflows/build.yml/badge.svg)](https://github.com/highb/asdf-teleport-ent/actions/workflows/build.yml) [![Lint](https://github.com/highb/asdf-teleport-ent/actions/workflows/lint.yml/badge.svg)](https://github.com/highb/asdf-teleport-ent/actions/workflows/lint.yml)


[teleport-ent](https://goteleport.com/docs/server-access/guides/tsh/) plugin for the [asdf version manager](https://asdf-vm.com) and [mise](https://mise.jdx.dev/).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

## With asdf

Plugin:

```shell
asdf plugin add teleport-ent
# or
asdf plugin add teleport-ent https://github.com/highb/asdf-teleport-ent.git
```

teleport-ent:

```shell
# Show all installable versions
asdf list all teleport-ent

# Install latest version
asdf install teleport-ent latest

# Install specific version
asdf install teleport-ent 14.2.2

# Set a version globally (on your ~/.tool-versions file)
asdf set -u teleport-ent latest

# Set a version locally for the current directory and all sub-directories
# This will also create a .tool-versions file which can be checked in to source control.
asdf set teleport-ent 14.2.2

# Now teleport-ent commands are available
tsh version
tctl version
teleport version
```

## With mise

Plugin:

```shell
mise plugin install teleport-ent
# or
mise plugin install teleport-ent https://github.com/highb/asdf-teleport-ent.git
```

teleport-ent:

```shell
# Show all installable versions
mise ls-remote teleport-ent

# Install latest version
mise install teleport-ent@latest

# Install specific version
mise install teleport-ent@14.2.2

# Set a version globally (on your ~/.tool-versions file)
mise global teleport-ent@latest

# Set a version locally for the current directory and all sub-directories
# This will also create a .tool-versions file which can be checked in to source control.
mise local teleport-ent@14.2.2

# Set a version for the current shell
mise shell teleport-ent@14.2.2

# Now teleport-ent commands are available
tsh version
tctl version
teleport version
```

Check [asdf](https://github.com/asdf-vm/asdf) or [mise](https://mise.jdx.dev/) documentation for more instructions on how to install & manage versions.

# Why?

When testing out version upgrades on Teleport, I frequently found myself jumping between
tsh/tctl versions and decided that I didn't want to manage a bunch of symlinks manually
so I made an asdf plugin. This plugin works with both asdf and mise version managers.

*I do not work for Gravitational* so this does not come with any support guarantees, but
please feel free to open a PR if you find a version that you need is missing or you need
some functionality added.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

Thanks to all contributors: [@vladlosev](https://github.com/vladlosev), [@notsag](https://github.com/notsag), [@aweris](https://github.com/aweris), [@NitriKx](https://github.com/NitriKx), [@drootsad](https://github.com/drootsad), [@gtback](https://github.com/gtback), [@gunzy83](https://github.com/gunzy83), and [@thampton](https://github.com/thampton).

# License

See [LICENSE](LICENSE) © [Brandon High](https://github.com/highb/)
