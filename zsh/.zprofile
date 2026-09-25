# Login-shell environment: PATH and tool locations.
# Lives here (not .zshenv) so macOS's /etc/zprofile path_helper runs first
# and can't push these entries behind the system paths.

typeset -U path   # drop duplicate PATH entries automatically

eval "$(/opt/homebrew/bin/brew shellenv)"

path=(
    /opt/homebrew/bin
    /opt/homebrew/sbin
    $HOME/.local/bin
    /Library/TeX/texbin
    $path
)
# conda/mamba: the mamba hook in .zshrc adds ~/miniforge3/condabin;
# use `mamba activate` for an environment's tools.

export JAVA_HOME="$(/usr/libexec/java_home 2>/dev/null)"

export NETCDF_ROOT=/opt/homebrew/opt/netcdf
export NETCDF_FORTRAN_ROOT=/opt/homebrew/opt/netcdf-fortran
