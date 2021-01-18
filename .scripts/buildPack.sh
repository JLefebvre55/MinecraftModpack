#!/bin/bash
set -e

modpack_config=modpack.json
modpack_output_zip=modpack.zip
build_folder=build
workspace_path=$(pwd)
download_forge_pattern='https://files.minecraftforge.net/maven/net/minecraftforge/forge/%version%/forge-%version%-universal.jar'

url_download_list=()
curse_mod_projectIds=()
curse_mod_fileIds=()

function modpack_structure {
    if [ -d "$build_folder" ]; then
        echo 'Clean up build folder...'
        rm -rf "$build_folder"
    fi

    echo 'Creating modpack folder structure...'
    [ -d "$build_folder" ] || mkdir "$build_folder"
    [ -d "$build_folder/bin" ] || mkdir "$build_folder/bin"
    [ -d "$build_folder/mods" ] || mkdir "$build_folder/mods"
    cd "$build_folder"
}

function download_file {
    download_url="$1"
    if [ "$2" ]; then
        progress_flag='-#'
    else
        progress_flag='-s'
    fi
    curl -O -J -L --globoff --compressed $progress_flag "$download_url" || (echo "Failed to download $download_url" && exit 1)
}

function install_curse_mods {

    echo 'Downloading curse mods'
    pushd "mods" > /dev/null
    export -f download_file

    index=0
    while [ $index -lt ${#curse_mod_projectIds[@]} ]; do
        projectId=${curse_mod_projectIds[$index]}
        fileId=${curse_mod_fileIds[$index]}
        echo "Download mod ${projectId}"

        download_url=$(curl -s "https://addons-ecs.forgesvc.net/api/v2/addon/${projectId}/file/${fileId}/download-url" | sed 's/ /%20/g')
        echo "Download url: ${download_url}"
        download_file "${download_url}" true

        index=$(( index + 1 ))
    done
    printf 'Finished downloading curse mods\n'
    popd > /dev/null
}

function install_forge {

    pushd "bin" > /dev/null
    forge_version=$(jq -r '.forgeVersion' "${workspace_path}/${modpack_config}")
    
    echo "Download forge version $forge_version"
    download_file ${download_forge_pattern//%version%/${forge_version}} true
    mv ./*.jar 'modpack.jar'

    popd > /dev/null
}

function read_mods {
    echo 'Collect mods...'

    save_ifs=$IFS
    IFS=$'\n'
    url_download_list=($(jq -r '.mods.urls[] // {} | .url' "${workspace_path}/${modpack_config}"))
    curse_mod_projectIds=($(jq -r '.mods.curse[] // {} | .projectId' "${workspace_path}/${modpack_config}"))
    curse_mod_fileIds=($(jq -r '.mods.curse[] // {} | .fileId' "${workspace_path}/${modpack_config}"))
    IFS=$save_ifs
}

function install_mods {
    echo 'Downloading mods'
    pushd "mods" > /dev/null
    export -f download_file
    echo ${url_download_list[@]} | xargs -n 1 -P 8 -I {} -d ' ' bash -c 'download_file "{}" && printf '.''
    printf 'Finished url mods\n'
    popd > /dev/null
}

function copy_overrides {
    echo 'Copy overrides folder in modpack...'
    cp -r -v "$workspace_path/overrides/." .
}

### Main ###

modpack_structure

install_forge

read_mods

if [ ! "$url_download_list" == 'null' ]; then
    install_mods
fi

if [ ! "$curse_mod_projectIds" == 'null' ]; then
    install_curse_mods
fi

copy_overrides

echo 'Create zip...'
zip -9 -r "$modpack_output_zip" .

echo "Created $modpack_output_zip"
