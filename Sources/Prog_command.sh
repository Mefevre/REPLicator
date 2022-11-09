# Add Var to the env
set() {
    ${REPL_var["$1"]}=$2
    echo -e "La variable ${RED}$1 ${WHITE}a bien été configurée à ${RED}$2"
}

# display all vat env
show(){
    echo -e "Variable enregistrer dans cette environnement : "
    for i in ${!REPL_var[@]}; do
        echo "  $i = ${tab["$i"]}"
    done
}

# execute tools
exec() {
    //
}

# show tools installed and supported
list () {
    update_soft_installer_all
    for i in ${!REPL_soft[@]}; do
        if [[ ${REPL_soft["$i"]} -eq 0 ]]; then
            echo "  $i = ${REPL_soft["$i"]}"
        fi
    done
}

update_soft_installer_all() {
    for i in ${!REPL_soft[@]}; do
        REPL_soft["$i"]=update_soft_installer $i
    done
}

update_soft_installer() {
    which $1
    return $?
}

# install tools supported
install() {
    apt install $1 -y
}

# Show doc prog
help() {
    //
}

# Show city weather
meteo() {
    //
}