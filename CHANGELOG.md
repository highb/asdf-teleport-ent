# Changelog

## [1.1.1](https://github.com/highb/asdf-teleport-ent/compare/v1.1.0...v1.1.1) (2026-08-30)


### Documentation

* fix changelog attribution for post-v1.0.6 commits ([a7cb263](https://github.com/highb/asdf-teleport-ent/commit/a7cb2639d5b31fc2fe1083387cb512941f063253))
* update README dependencies and install examples ([7c986db](https://github.com/highb/asdf-teleport-ent/commit/7c986dbfef9156e0cef13a0d0c15c98372e0161a))


### Miscellaneous Chores

* remove stale TODO from bin/download ([232fa21](https://github.com/highb/asdf-teleport-ent/commit/232fa21024c40a0b128c8e4633db96e724e3cd7c))

## [1.1.0](https://github.com/highb/asdf-teleport-ent/compare/v1.0.6...v1.1.0) (2026-08-30)


### Features

* Allow -fips versions of teleport-ent CLI ([ad34d04](https://github.com/highb/asdf-teleport-ent/commit/ad34d048ada418a7bac9bbfb4f4eee0e58833a4d))
* filter version listing to supported majors (v17, v18) ([46256bc](https://github.com/highb/asdf-teleport-ent/commit/46256bc6a17eb820a79316c4d8b71ebe1e6f2a7b))


### Bug Fixes

* local fips_build variable in download_release ([fea15d8](https://github.com/highb/asdf-teleport-ent/commit/fea15d86326a6cd1e2b43826919a6fdc21b8622e))


### Documentation

* list all contributors by name in thanks section ([ebd60a4](https://github.com/highb/asdf-teleport-ent/commit/ebd60a4dc0c5bceb5b3318421abd0ddeaac7d373))
* remove self from contributor thanks ([a6e0dea](https://github.com/highb/asdf-teleport-ent/commit/a6e0dea41ed7ec10550c3f9febbd50a1a4bfc0b5))


### Build System

* add contributor thanks to changelog and helper script ([7f41f75](https://github.com/highb/asdf-teleport-ent/commit/7f41f7537bc5bbb4ecacc8c9a227a5017eb7fc5f))
* add mise tasks for lint and contributors ([7587580](https://github.com/highb/asdf-teleport-ent/commit/7587580eff3b26ca2a233158be3ddd5494623125))
* fix release-please config and regenerate changelog ([4f91a80](https://github.com/highb/asdf-teleport-ent/commit/4f91a8043760c9097bad54e1e3faf5283599bc62))


### Miscellaneous Chores

* add .mise.toml, remove stale TODOs, consolidate renovate mise group ([486c1dd](https://github.com/highb/asdf-teleport-ent/commit/486c1dda8e9273c8adbba0e751ae41a07622d664))

## [1.0.6](https://github.com/highb/asdf-teleport-ent/compare/v1.0.5...v1.0.6) (2026-08-30)


### Bug Fixes

* Update download URL and add mise support ([7099dfd](https://github.com/highb/asdf-teleport-ent/commit/7099dfd))


### Documentation

* update the README with the new asdf 0.16 commands ([c310e9a](https://github.com/highb/asdf-teleport-ent/commit/c310e9a))


### Dependencies

* update dependency shfmt to v3.12.0 ([af4e74e](https://github.com/highb/asdf-teleport-ent/commit/af4e74e))
* update actions/checkout action to v5 ([4242e49](https://github.com/highb/asdf-teleport-ent/commit/4242e49))
* update dependency shellcheck to v0.11.0 ([f156fc4](https://github.com/highb/asdf-teleport-ent/commit/f156fc4))
* update actions/checkout action to v6 ([39c978a](https://github.com/highb/asdf-teleport-ent/commit/39c978a))
* update dependency shfmt to v3.14.0 ([25da8b2](https://github.com/highb/asdf-teleport-ent/commit/25da8b2))
* update github-actions ([f04d3ae](https://github.com/highb/asdf-teleport-ent/commit/f04d3ae))


### Build System

* group renovate PRs by file to reduce noise ([e4977ad](https://github.com/highb/asdf-teleport-ent/commit/e4977ad))

### Thanks

* @drootsad, @notsag, @thampton

## [1.0.5](https://github.com/highb/asdf-teleport-ent/compare/v1.0.4...v1.0.5) (2025-03-06)


### Bug Fixes

* Linux/ARM64 install. ([96fe97f](https://github.com/highb/asdf-teleport-ent/commit/96fe97fc97e3642ef27262be6d22cabb8e22a411))
* Linux/ARM64 install. ([33e39f6](https://github.com/highb/asdf-teleport-ent/commit/33e39f6675c251904b332218eeeb076cc98a7836))
* Sends output of fail() to stderr. ([a2942ae](https://github.com/highb/asdf-teleport-ent/commit/a2942ae518e177cbe80230d4cac1f705723660bd))

## [1.0.4](https://github.com/highb/asdf-teleport-ent/compare/v1.0.3...v1.0.4) (2025-03-05)


### Bug Fixes

* Lint errors. ([b897fcf](https://github.com/highb/asdf-teleport-ent/commit/b897fcff61d3ec521ce1c54afa512d4c40d6b7d6))
* MacOS install for app bundles. ([1cb4b90](https://github.com/highb/asdf-teleport-ent/commit/1cb4b900bfaf48c55ddffdee71d7c93d96b8f738))

## [1.0.3](https://github.com/highb/asdf-teleport-ent/compare/v1.0.2...v1.0.3) (2025-02-05)


### Bug Fixes

* Handles MacOS app bundles. ([84a4c39](https://github.com/highb/asdf-teleport-ent/commit/84a4c3973e4847d21f4119bb3affe46d66ad0aca))

## [1.0.1](https://github.com/highb/asdf-teleport-ent/compare/v1.0.0...v1.0.1) (2023-12-11)


### Bug Fixes

* Default version if no GH, update linter to ensure conventional commit ([ab98760](https://github.com/highb/asdf-teleport-ent/commit/ab9876057697e84276ecc1091b205f5389aecad2))
* Use commitizen to check commits ([f019ea1](https://github.com/highb/asdf-teleport-ent/commit/f019ea1274ce02abd7a2995bd0926fe127f8f89b))
