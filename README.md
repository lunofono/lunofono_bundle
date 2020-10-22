# lunofono\_bundle [![Sponsor](https://img.shields.io/badge/-Sponsor-555555?style=flat-square)](https://github.com/llucax/llucax/blob/main/sponsoring-platforms.md)[![GitHub Sponsors](https://img.shields.io/badge/--ea4aaa?logo=github&style=flat-square)](https://github.com/sponsors/llucax)[![Liberapay](https://img.shields.io/badge/--f6c915?logo=liberapay&logoColor=black&style=flat-square)](https://liberapay.com/llucax/donate)[![Paypal](https://img.shields.io/badge/--0070ba?logo=paypal&style=flat-square)](https://www.paypal.com/donate?hosted_button_id=UZRR3REUC4SY2)[![Buy Me A Coffee](https://img.shields.io/badge/--ff813f?logo=buy-me-a-coffee&logoColor=white&style=flat-square)](https://www.buymeacoffee.com/llucax)[![Patreon](https://img.shields.io/badge/--f96854?logo=patreon&logoColor=white&style=flat-square)](https://www.patreon.com/llucax)[![Flattr](https://img.shields.io/badge/--6bc76b?logo=flattr&logoColor=white&style=flat-square)](https://flattr.com/@llucax)
[![CI](https://github.com/lunofono/lunofono_bundle/workflows/CI/badge.svg)](https://github.com/lunofono/lunofono_bundle/actions?query=branch%3Amain+workflow%3ACI+)
[![Pub Score](https://github.com/lunofono/lunofono_bundle/workflows/Pub%20Score/badge.svg)](https://github.com/lunofono/lunofono_bundle/actions?query=branch%3Amain+workflow%3A%22Pub+Score%22+)
[![Coverage](https://codecov.io/gh/lunofono/lunofono_bundle/branch/main/graph/badge.svg)](https://codecov.io/gh/lunofono/lunofono_bundle)

A library to manage content bundles for Lunofono

## Contributing

This project is written in [Flutter](https://flutter.dev/). Once you have
a working Flutter SDK installed, you can test it using `flutter test`.

### Git Hooks

This repository provides some useful Git hooks to make sure new commits have
some basic health.

The hooks are provided in the `.githooks/` directory and can be easily used by
configuring git to use this directory for hooks instead of the default
`.git/hooks/`:

```sh
git config core.hooksPath .githooks
```

So far there is a hook to prevent commits with the `WIP` word in the message to
be pushed, and one hook to run `flutter analyze` and `flutter test` before
a new commit is created. The later can take some time, but it can be easily
disabled temporarily by using `git commit --no-verify` if you are, for example,
just changing the README file or amending a commit message.
