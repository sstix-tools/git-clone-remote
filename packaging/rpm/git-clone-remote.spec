Name:           git-clone-remote
Version:        %{version}
Release:        1%{?dist}
Summary:        Copy branches and tags to another Git remote
License:        MIT
BuildArch:      noarch
Requires:       bash
Requires:       git
Requires:       grep

%description
A Bash utility for mirroring Git branches and tags to another remote.

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_datadir}/zsh/site-functions
install -m 0755 %{_sourcedir}/git-clone-remote %{buildroot}%{_bindir}/git-clone-remote
install -m 0644 %{_sourcedir}/_git-clone-remote %{buildroot}%{_datadir}/zsh/site-functions/_git-clone-remote

%files
%{_bindir}/git-clone-remote
%{_datadir}/zsh/site-functions/_git-clone-remote
