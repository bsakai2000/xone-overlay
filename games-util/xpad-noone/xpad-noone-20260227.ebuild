# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

# Latest commit
VERSION="7b5361475c719b03b9e0152e44cf7fca0b85af60"


DESCRIPTION="Linux kernel driver for Xbox 360 controllers with Xbox One support removed"
HOMEPAGE="https://github.com/medusalix/xpad-noone"
SRC_URI="https://github.com/forkymcforkface/xpad-noone/archive/${VERSION}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${VERSION}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

CONFIG_CHECK="INPUT_JOYDEV INPUT_JOYSTICK"
# No idea but matching commit history
MODULES_KERNEL_MIN=6.16

src_prepare() {
	# Use custom Makefile to use KERNEL_DIR instead of guessing it with uname
	cp "${FILESDIR}/Makefile" "${S}" || die
	eapply_user
}

src_compile() {
	local modlist=(
		xpad-noone=kernel/drivers/input/joystick
	)

	linux-mod-r1_src_compile
}
