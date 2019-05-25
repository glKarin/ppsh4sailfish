Name: ppsh
%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}
Summary: PPSH is a web-video player for Bilibili.
Vendor: karin <beyondk2000@gmail.com>
Packager: karin <beyondk2000@gmail.com>
Version: 43.0.6harmattan2
Release: bilibili0
# The contents of the Group field should be one of the groups listed here:
# https://github.com/mer-tools/spectacle/blob/master/data/GROUPS
Group: Qt/Qt
URL: https://github.com/glKarin/ppsh_sailfish
License: GPLv2
# This must be generated before uploading a package to a remote build service.
# Usually this line does not need to be modified.
Source0: %{name}.tar.gz
#BuildRoot:	%(mktemp -ud %{name})
BuildRequires:	pkgconfig(sailfishapp) >= 1.0.2
BuildRequires:	pkgconfig(Qt5Core)
BuildRequires:	pkgconfig(Qt5Qml)
BuildRequires:	pkgconfig(Qt5Quick)
BuildRequires:	pkgconfig(Qt5Xml)
BuildRequires:	pkgconfig(Qt5Network)
BuildRequires:	pkgconfig(Qt5Widgets)
BuildRequires:	pkgconfig(Qt5Multimedia)
BuildRequires:	pkgconfig(Qt5Sql)
Requires: sailfishsilica-qt5 >= 0.10.9 
Requires:   libkeepalive

%description
%{summary}
 PPSH is based on Bilibili web API.

%prep
%setup -q -n %{name}

%build
qmake -qt=5 MEEGO_EDITION=nemo -spec linux-g++
# Inject version number from RPM into source
make

%install
rm -rf %{buildroot}
make INSTALL_ROOT=%{buildroot} install


# All installed files
%files
%{_bindir}
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/80x80/apps/%{name}80.png

# For more information about yaml and what's supported in Sailfish OS
# build system, please see https://wiki.merproject.org/wiki/Spectacle

%changelog
* Fri May 24 2019 Karin Zhao <beyondk2000@gmail.com> - 43.0.6harmattan2
 * Fixed layout.
 * Add view full comment and reply.
 * Add live, include search.
 * Close screen saver when playing by 0312birdzhang.
 * Some fix.
