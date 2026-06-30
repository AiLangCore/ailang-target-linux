# AiLang Linux Target

Official AiLang target package for Linux.

This target is for normal Linux desktop/server environments. AiOS shell-less
images live in `ailang-target-aios`.

Current package release: `0.0.1-alpha.2`.

## Package

```text
packages/target-linux
```

## Status

Package discovery is enabled. The current alpha target package declares the
normal Linux target contract and delegates to the SDK's built-in Linux
run/publish path while Linux-specific host packaging is moved into this
repository.

Supported target identifiers:

```text
linux
gnu-linux
```

Declared artifact types:

```text
dir
tar.gz
appimage
deb
rpm
```

Declared options:

```text
arch
desktop
service
package-format
```

## Usage

```bash
ailang package restore
ailang run . --target linux
ailang publish . --target linux --target-option package-format=tar.gz
```

Local `run` requires a Linux host. Desktop packaging, service packaging, distro
packages, and Linux host-library work remain target-owned responsibilities for
this repository.
