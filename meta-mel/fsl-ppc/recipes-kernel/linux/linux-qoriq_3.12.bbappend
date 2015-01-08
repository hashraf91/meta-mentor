def src_config_fragments(d):
    sources = src_patches(d, True)
    return [s for s in sources if s.endswith('.cfg')]

DELTA_KERNEL_DEFCONFIG += "${@' '.join(src_config_fragments(d))}"

SRC_URI_append = " file://nbd.cfg \
                   file://autofs.cfg \
                   file://lttng.cfg"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
FILESEXTRAPATHS_append = ":${@os.path.dirname(bb.utils.which(BBPATH, 'files/lttng.cfg') or '')}"

KERNEL_SRC_URI ?= "https://s3.amazonaws.com/portal.mentor.com/sources/MEL-2014.12/linux-qoriq-3.12.tar.xz"
SRC_URI = "${KERNEL_SRC_URI} \
    file://powerpc-Fix-64-bit-builds-with-binutils-2.24.patch \
    file://Fix-for-CVE-2014-5045-fs-umount-on-symlink-leak.patch \
    file://Fix-CVE-2014-5077-sctp-inherit-auth-capable-on-INIT-collisions.patch \
    file://Fix-CVE-2014-5471_CVE-2014-5472.patch \
"

SRC_URI += "${@base_contains('DISTRO_FEATURES', 'systemd', ' file://systemd.cfg', '', d)}"

SRC_URI[md5sum] = "104dbde5f27007317b48e2314fa3faee"
SRC_URI[sha256sum] = "1d651bc5a0047f5c5ce56c8494cda4918b59d13079d0efcc1a555014d02b24f9"
S = "${WORKDIR}/${BP}"
