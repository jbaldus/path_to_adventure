# Avoid duplicate inclusion
if [[ -n "${__pta_gather_resources_imported:-}" ]]; then
    return 0
fi
__pta_gather_resources_imported="defined"

source .lib/utils.sh

# This script will gather all the `__pta_resources` directories here into 
# $RESOURCES. The `__pta_resources` directories will be renamed to their 
# parent directories, so, for example, the 
# `$WORLD/forest/cave/__pta_resources` directory will be moved 
# to `$RESOURCES/World/forest/cave`.


function __pta_extract_resources {
    shopt -s dotglob
    local RESOURCE_DIR
    for RESOURCE_DIR in $(sudo find -H $WORLD -type d -name __pta_resources 2>/dev/null); do
        local DEST_DIR="${RESOURCES}$(dirname "$RESOURCE_DIR")"
        dbg "$RESOURCE_DIR will be moved to $DEST_DIR"
        mkdir -p "$(dirname "$DEST_DIR")"
        if [[ -d "$DEST_DIR" ]]; then
            mv "$RESOURCE_DIR"/* "$DEST_DIR/"
            rmdir "$RESOURCE_DIR"
        else
            mv "$RESOURCE_DIR" "$DEST_DIR"
        fi
    done
    shopt -u dotglob
}

