#
# Create by dovanquyen.vn@gmail.com
# 
#

DESCRIPTION = "training example S/W"
SECTION = "training/example"
LICENSE = "CLOSED"

PROVIDES = "example"
RPROVIDES_${PN} = "example"

DEPENDS += ""
RDEPENDS_${PN} += ""

# This tells bitbake where to find the files we're providing on the local filesystem
FILESEXTRAPATHS_prepend := "${THISDIR}:"
SRC_URI += "file://example-1.0"

# Make sure our source directory (for the build) matches the directory structure in the tarball
S = "${WORKDIR}/example-1.0"

show_var() {
	echo "S : ${S}"
	echo "B : ${B}"
	echo "D : ${D}"
	echo "BINDIR : ${bindir}"
	echo "WORKDIR : ${WORKDIR}"
	echo "TOPDIR : ${TOPDIR}"
	echo "THISDIR : ${THISDIR}"
	echo "DEPLOY_DIR_IMAGE : ${DEPLOY_DIR}"
	echo "IMAGE_NAME : ${IMAGE_NAME}"
	echo "IMAGE_ROOTFS : ${IMAGE_ROOTFS}"
	echo "TARGET_PREFIX : ${TARGET_PREFIX}"
	echo "TMPDIR : ${TMPDIR}"
	echo "MACHINE : ${MACHINE}"
	echo "TARGET_SYS : ${TARGET_SYS}"
	echo "CC : ${CC}"

# If you want to see variables, uncommenting following line could be good solution.
#	exit 1
}

build_app() {
	make -C ${S}/ \
		IMAGE_ROOTFS="${D}" \
		TARGET_PREFIX="${TARGET_PREFIX}" \
		TARGET_CC="${CC}" \
		TARGET_AR="${AR}" \
		TMPDIR="${TMPDIR}" \
		MACHINE="${MACHINE}" \
		TARGET_SYS="${TARGET_SYS}" \
		DATETIME="${DATEME}" \
		install
}

do_configure() {
}

do_compile() {
	show_var
	build_app
}

do_install() {
	if [ -f "${S}/example" ] ; then \
		cp -f ${S}/example ${D}${bindir} ;\
	fi;
}

do_install[dirs] = "${D}${bindir}"

FILES_${PN} = "${bindir}/*"

