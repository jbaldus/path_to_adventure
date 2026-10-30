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
    local resource_dir
    for resource_dir in $(find -H $WORLD -type d -name __pta_resources 2>/dev/null); do
        local dest_dir="${RESOURCES}$(dirname "$resource_dir")"
        dbg "$resource_dir will be moved to $dest_dir"
        mkdir -p "$(dirname "$dest_dir")"
        if [[ -d "$dest_dir" ]]; then
            mv "$resource_dir"/* "$dest_dir/"
            rmdir "$resource_dir"
        else
            mv "$resource_dir" "$dest_dir"
        fi
    done
    shopt -u dotglob
}

