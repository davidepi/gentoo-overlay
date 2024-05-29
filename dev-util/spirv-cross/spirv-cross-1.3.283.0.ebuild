EAPI=8

inherit cmake

DESCRIPTION="Tool and library for performing reflection on SPIR-V and disassembling SPIR-V back to high level languages."
HOMEPAGE="https://github.com/KhronosGroup/SPIRV-Cross"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/KhronosGroup/${PN}.git"
	inherit git-r3
else
	EGIT_COMMIT="vulkan-sdk-${PV}"
	SRC_URI="https://github.com/KhronosGroup/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 arm arm64 ~loong ppc ppc64 ~riscv x86"
	S="${WORKDIR}"/"SPIRV-Cross-${EGIT_COMMIT}"
fi

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cli -shared +static"
REQUIRED_USE="
	cli? ( static )
"
RESTRICT="test"

src_prepare() {
    cmake_src_prepare
}

src_configure() {
    local mycmakeargs=(
        -DSPIRV_CROSS_CLI="$(usex cli)"
        -DSPIRV_CROSS_SHARED="$(usex shared)"
        -DSPIRV_CROSS_STATIC="$(usex static)"
    )
    cmake_src_configure
}


