FROM quay.io/fedora/fedora-bootc:40

RUN dnf install -y dnf-plugins-core && \
    dnf config-manager --save \
        --setopt=exclude=rootfiles,firefox,PackageKit,PackageKit-command-not-found

# Install KDE Plasma
RUN dnf install -y @kde-desktop-environment && systemctl enable sddm

# Import vscode repo
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

RUN dnf install -y code osbuild-selinux