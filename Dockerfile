# Note: You can use any Debian/Ubuntu based image you want. 
FROM harbor.test.geely.com/imd/c-cpp:rev-617299bfda5fcc997f5cf04dd6f8e91001c73670

# Install needed packages and setup non-root user. Use a separate RUN statement to add your
# own dependencies. A user of "automatic" attempts to reuse an user ID if one already exists.

# RUN if [ $(getent passwd $USERNAME) ]; then \ 
#         # If exists, see if we need to tweak the GID/UID
#         if [ "$USER_GID" != "1005" ] || [ "$USER_UID" != "1005" ]; then \
#             groupmod --gid $USER_GID $USERNAME \
#             && usermod --uid $USER_UID --gid $USER_GID $USERNAME \
#             && chown -R $USER_UID:$USER_GID /home/$USERNAME; \
#         fi; \
#     else \
#         # Otherwise ccreate the non-root user
#         groupadd --gid $USER_GID $USERNAME \
#         && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
#         # Add sudo support for the non-root user, anthor methord change password `echo "kl123" | passwd --stdin HwHiAiUser`
#         && apt-get install -y sudo \
#         && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
#         && chmod 0440 /etc/sudoers.d/$USERNAME; \
#     fi

# USER ${USERNAME}

ADD remote/vscode-server-linux-x64.tar.gz /root/.vscode-server/bin/
COPY remote/vs-code-extensiton /tmp/vs-code-extensiton
#you cat get id from vscode abort
Run mv /root/.vscode-server/bin/vscode-server-linux-x64 /root/.vscode-server/bin/e18005f0f1b33c29e81d732535d8c0e47cafb0b5 && \
    cd /root/.vscode-server/bin/e18005f0f1b33c29e81d732535d8c0e47cafb0b5/bin && \
    for plugin in $(ls /tmp/vs-code-extensiton);do ./code-server --install-extension /tmp/vs-code-extensiton/$plugin;done && \
    rm -r /tmp/vs-code-extensiton

