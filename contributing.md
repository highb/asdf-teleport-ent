# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test teleport-ent https://github.com/highb/asdf-teleport-ent.git "tsh version"
```

Tests are automatically run in GitHub Actions on push and PR.

## Commit Style

We use [Conventional Commit](https://www.conventionalcommits.org/en/v1.0.0/)
style commit messages. This allows us to automate release versioning and
changelog generation. Here is a quick reference for how to write commit messages
in this style:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

Valid types are:

- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- `refactor`: A code change that neither fixes a bug nor adds a feature
- `perf`: A code change that improves performance
- `test`: Adding missing tests or correcting existing tests
- `build`: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- `ci`: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- `chore`: Other changes that don't modify src or test files
- `revert`: Reverts a previous commit
