#!/bin/sh
set -e
repo="$(pwd)"
zipper="${repo}/external/bazel_tools/tools/zip/zipper/zipper"
archive="${repo}/bazel-out/k8-fastbuild/bin/release/v2ray-linux-arm32-v6.zip"
tmp="$(mktemp -d "${TMPDIR:-/tmp}/zip_file.XXXXXXXXXX")"
cd "${tmp}"
mkdir -p "${tmp}/systemd/system"
ln -sf "${repo}/release/config/config.json" "${tmp}/config.json"
ln -sf "${repo}/release/config/vpoint_socks_vmess.json" "${tmp}/vpoint_socks_vmess.json"
ln -sf "${repo}/release/config/vpoint_vmess_freedom.json" "${tmp}/vpoint_vmess_freedom.json"
ln -sf "${repo}/release/config/geoip.dat" "${tmp}/geoip.dat"
ln -sf "${repo}/release/config/geosite.dat" "${tmp}/geosite.dat"
ln -sf "${repo}/release/config/systemd/system/v2ray.service" "${tmp}/systemd/system/v2ray.service"
ln -sf "${repo}/release/config/systemd/system/v2ray@.service" "${tmp}/systemd/system/v2ray@.service"
ln -sf "${repo}/bazel-out/k8-fastbuild/bin/infra/control/main/linux/arm/6/v2ctl" "${tmp}/v2ctl"
ln -sf "${repo}/bazel-out/k8-fastbuild/bin/infra/control/main/linux/arm/6/v2ctl.sig" "${tmp}/v2ctl.sig"
ln -sf "${repo}/bazel-out/k8-fastbuild/bin/main/linux/arm/6/v2ray" "${tmp}/v2ray"
ln -sf "${repo}/bazel-out/k8-fastbuild/bin/main/linux/arm/6/v2ray.sig" "${tmp}/v2ray.sig"
find . | sed 1d | cut -c 3- | LC_ALL=C sort | xargs "${zipper}" cC "${archive}"
cd "${repo}"
rm -rf "${tmp}"