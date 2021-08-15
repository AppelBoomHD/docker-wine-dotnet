FROM scottyhardy/docker-wine

ENV WINEDEBUG "fixme-all"

#RUN export DISPLAY=:0 \
#    && (Xvfb $DISPLAY -screen 0 1024x768x24 > /dev/null 2>&1 &) \
#    && wine wineboot --init \
#    && winetricks --unattended --force -q dotnet20 dotnet462 dotnet_verifier \
#    && while pgrep wineserver >/dev/null; do echo "Waiting for wineserver"; sleep 1; done \
#    && rm -rf $HOME/.cache/winetricks

RUN export USE_XVFB=yes \
    && export XVFB_SERVER=":95" \
    && export XVFB_SCREEN="0" \
    && export XVFB_RESOLUTION="320x240x8" \
    && export DISPLAY="${XVFB_SERVER}" \
    && export RUN_AS_ROOT=yes \
    && export WINEARCH=win32 \
    && export WINEPREFIX="$(realpath ~/.wine32)" \
    && entrypoint wineboot --init \
    && winetricks --unattended --force cmd dotnet20 dotnet472 corefonts \
    && while pgrep wineserver >/dev/null; do echo "Waiting for wineserver"; sleep 1; done \
    && rm -rf $HOME/.cache/winetricks

RUN export USE_XVFB=yes \
    && export XVFB_SERVER=":95" \
    && export XVFB_SCREEN="0" \
    && export XVFB_RESOLUTION="320x240x8" \
    && export DISPLAY="${XVFB_SERVER}" \
    && export RUN_AS_ROOT=yes \
    && export WINEARCH=win64 \
    && export WINEPREFIX="$(realpath ~/.wine64)" \
    && entrypoint wineboot --init \
    && winetricks --unattended --force cmd dotnet20 dotnet472 corefonts \
    && while pgrep wineserver >/dev/null; do echo "Waiting for wineserver"; sleep 1; done \
    && rm -rf $HOME/.cache/winetricks

RUN ln -s ~/.wine32 ~/.wine
