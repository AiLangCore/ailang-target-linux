# AiLang Linux Target

Official AiLang target package for Linux.

This target is for normal Linux desktop/server environments. AiOS shell-less
images live in `ailang-target-aios`.

Current package release: `0.0.1-alpha.7`.

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
qemu-seed
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
qemu-serial-log
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

On Apple Silicon, the runner uses an ARM64 Linux guest for local Linux/X11
validation. The runner publishes a Linux ARM64 build, starts a QEMU guest when
needed, copies the output into the guest over SSH, and launches it with
`DISPLAY=:0`.

If no guest image is configured, the target prepares a cached Ubuntu ARM64 cloud
image with SSH and a lightweight X11/Openbox session. The generated development
guest uses the local user `ailang` with passwordless sudo and SSH forwarding on
the configured host port.

```bash
ailang run . \
  --target linux \
  --target-option runner=qemu \
  --target-option arch=aarch64
```

The runner defaults to QEMU ARM64 with `virt`, `hvf`, `host` CPU, `cocoa`
display, `virtio-gpu-pci`, USB keyboard/tablet, and user networking with SSH
forwarded to the configured port. Boot diagnostics are captured in
`.ailang/qemu-linux/serial.log` by default.

To prepare the guest without running an app:

```bash
packages/target-linux/tools/prepare-qemu --arch aarch64
```

Override the generated guest image when needed:

```bash
ailang run . \
  --target linux \
  --target-option runner=qemu \
  --target-option arch=aarch64 \
  --target-option qemu-image=/path/to/linux-arm64.qcow2 \
  --target-option qemu-user=ailang \
  --target-option qemu-ssh-port=2222
```
