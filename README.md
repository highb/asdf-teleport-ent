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

# Install specific version
asdf install teleport-ent latest

# Set a version globally (on your ~/.tool-versions file)
asdf global teleport-ent latest

# Now teleport-ent commands are available
tsh version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/highb/asdf-teleport-ent/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Brandon High](https://github.com/highb/)
