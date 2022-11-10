# Add Var to the env
set() {
    REPL_var["$1"]=$2
    echo -e "La variable ${RED}$1 ${WHITE}a bien été configurée à ${RED}$2"
}

# Delete var to the env
del() {
    unset REPL_var["$1"]
}

# display all var env
show() {
    echo -e "Variable enregistrer dans cette environnement : "
    for i in ${!REPL_var[@]}; do
        echo "  $i = ${REPL_var["$i"]}"
    done
}

# execute tools
exec() {
    //
}

# show tools installed and supported FIRT VUE
# list () {
#     update_soft_installer_all
#     echo -e "list of compatible programs : "
#     for i in ${!REPL_soft[@]}; do
#         if [[ ${REPL_soft["$i"]} -eq 2 ]]; then
#             echo "  $i = ${REPL_soft["$i"]}"
#         fi
#     done
# }
# SECOND VUE
list() {
    update_soft_installer_all
    if [[ $# -gt 0 ]]; then
        echo -e "This programs are installed : "
        for i in $@; do
            if [[ ${REPL_soft["$i"]} -eq 1 ]]; then
                echo -e "   - $i               $GREEN[INSTALLED]$END"
            fi
        done
    else
        echo -e "list of compatible programs : "
        for i in ${!REPL_soft[@]}; do
            if [[ ${REPL_soft["$i"]} -ne 0 ]]; then
                echo -n "   - $i    "
                if [[ ${REPL_soft["$i"]} -eq 1 ]]; then
                    echo -e -n "           $GREEN[INSTALLED]$END"
                fi
                echo ""
            fi
        done
    fi
}

update_soft_installer_all() {
    for i in ${!REPL_soft[@]}; do
        REPL_soft['$i']=$(update_soft_installer $i)
    done
}

update_soft_installer() {
    which $1
    if [[ $? -eq 0 ]]; then
        return 1
    else
        return 2
    fi
}

# install tools supported
install() {
    sudo apt install $1 -y
}

# Show doc prog
help() {
    //
}

# Show city weather
meteo() {
    //
}