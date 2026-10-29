Name:           template-bash-utility
Version:        %{version}
Release:        1%{?dist}
Summary:        Bash script utility template
License:        MIT
BuildArch:      noarch
Requires:       coreutils

%description
A utility script packaged for sstix-tools.

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_datadir}/zsh/site-functions
install -m 0755 %{_sourcedir}/template-bash-utility %{buildroot}%{_bindir}/template-bash-utility
install -m 0644 %{_sourcedir}/_template-bash-utility %{buildroot}%{_datadir}/zsh/site-functions/_template-bash-utility

%files
%{_bindir}/template-bash-utility
%{_datadir}/zsh/site-functions/_template-bash-utility
