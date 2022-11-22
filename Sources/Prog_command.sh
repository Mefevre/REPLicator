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
        echo "      $i = ${REPL_var["$i"]}"
    done
}

# execute tools
exec() {
    case $1 in
        nmap)
            # Execution de NMAP avec les options -sS=TCP SYNK -sU=SCAN UDP -Pn=NO PING -v=verbose -O=detection OS -p=PORT
            sudo nmap -sS -sU -Pn -v -O -p ${REPL_var["PORT"]} ${REPL_var["TARGET"]} -oN ${REPL_var["OUTPUTFILE"]}
            ;;
        gobuster)
            ;;
        sqlmap)
            sqlmap -u ${REPL_var["TARGET"]} -a --dump-format ${REPL_var["output_dump"]}
            echo -e "\n\nVous pouvez voir la sortie du script ici : $PURPLE/home/$USER/.local/share/sqlmap/output/MONSITE.FR$END\n"
            ;;
    esac
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
        update_soft_installer $i
        REPL_soft["$i"]=$?
    done
}

update_soft_installer() {
    which $1 > /dev/null
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

# Switch mode between assiste <=> expert
mode() {
    if [[ ${REPL_var["mode"]} == "expert" ]]; then
        center "$GREEN $   Assisté Mode   $ $END"
        REPL_var["mode"]="assiste"
        REPL_var["mode_color"]=$GREEN
    else
        center "$RED $   Expert Mode   $ $END"
        REPL_var["mode"]="expert"
        REPL_var["mode_color"]=$RED
    fi
}

# Show city weather
meteo() {
    curl wttr.in/$1
}

# RELAX FUNCT
cool() {
    curl parrot.live
}