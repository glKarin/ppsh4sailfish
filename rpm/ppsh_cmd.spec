Name: ppsh
Summary: PPSH is a web-video player for Bilibili.
Version: 43.0.5harmattan1
Release: bilibili
Vendor: karin <beyondk2000@gmail.com>
Packager: karin <beyondk2000@gmail.com>
Group: Qt/Qt
URL: https://github.com/glKarin/ppsh4sailfish
License: GPLv2
Source0: %{name}.tar.gz
BuildRoot:	%(mktemp -ud %{name})
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

%changelog
* Sun May 19 2019 Karin Zhao <beyondk2000@gmail.com> - 43.0.5harmattan1_bilibili
	* Add live, include search.
	* Close screen saver when playing by 0312birdzhang.
	* Some fix.

