# AiLang Linux Target

Official AiLang target package for Linux.

This target is for normal Linux desktop/server environments. AiOS shell-less
images live in `ailang-target-aios`.

Current package release: `0.0.1-alpha.3`.

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
runner
qemu-image
qemu-efi-code
qemu-efi-vars
qemu-efi-vars-template
qemu-user
qemu-ssh-port
qemu-ssh-key
qemu-display
qemu-memory
qemu-smp
qemu-accel
qemu-cpu
qemu-guest-display
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

## QEMU Runner

On Apple Silicon, use an ARM64 Linux guest for local Linux/X11 validation. The
runner publishes a Linux ARM64 build, starts a prepared QEMU guest when needed,
copies the output into the guest over SSH, and launches it with `DISPLAY=:0`.

The guest image must already contain a working Linux desktop session, SSH
server, and the target user. The target package does not bundle a Linux
distribution.

```bash
ailang run . \
  --target linux \
  --target-option runner=qemu \
  --target-option arch=aarch64 \
  --target-option qemu-image=/path/to/linux-arm64.qcow2 \
  --target-option qemu-user=ailang \
  --target-option qemu-ssh-port=2222
```

The runner defaults to QEMU ARM64 with `virt`, `hvf`, `host` CPU, `cocoa`
display, `virtio-gpu-pci`, USB keyboard/tablet, and user networking with SSH
forwarded to the configured port.
