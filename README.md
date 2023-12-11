<div align="center">

# asdf-teleport-ent [![Build](https://github.com/highb/asdf-teleport-ent/actions/workflows/build.yml/badge.svg)](https://github.com/highb/asdf-teleport-ent/actions/workflows/build.yml) [![Lint](https://github.com/highb/asdf-teleport-ent/actions/workflows/lint.yml/badge.svg)](https://github.com/highb/asdf-teleport-ent/actions/workflows/lint.yml)


[teleport-ent](https://goteleport.com/docs/server-access/guides/tsh/) plugin for the [asdf version manager](https://asdf-vm.com).

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

Plugin:

```shell
asdf plugin add teleport-ent
# or
asdf plugin add teleport-ent https://github.com/highb/asdf-teleport-ent.git
```

teleport-ent:

```shell
# Show all installable versions
asdf list-all teleport-ent

# Install latest version
asdf install teleport-ent latest

# Install specific version
asdf install teleport-ent 14.2.2

# Set a version globally (on your ~/.tool-versions file)
asdf global teleport-ent latest

# Set a version locally for the current directory and all sub-directories
# This will also create a .tool-versions file which can be checked in to source control.
asdf local teleport-ent 14.2.2

# Set a version for the current shell
asdf shell teleport-ent 14.2.2

# Now teleport-ent commands are available
tsh version
tctl version
teleport version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Why?

When testing out version upgrades on Teleport, I frequently found myself jumping between
tsh/tctl versions and decided that I didn't want to manage a bunch of symlinks manually
so I made an asdf plugin.

*I do not work for Gravitational* so this does not come with any support guarantees, but
please feel free to open a PR if you find a version that you need is missing or you need
some functionality added.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/highb/asdf-teleport-ent/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Brandon High](https://github.com/highb/)
