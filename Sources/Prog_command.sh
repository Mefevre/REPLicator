# Add Var to the env
set() {
    if [[ "`toLower $1`" == "mode" ]]; then
        echo -e "${ROSE}Impossible de set la variable MODE : Autorisation non permise !$END"
        return 1
    fi
    for i in ${!REPL_var[@]}; do
        if [[ "`toLower $1`" == "`toLower $i`" ]];then
            REPL_var["$i"]=$2
            echo -e "La variable ${GREEN}$i ${WHITE}a bien été configurée à ${GREEN}$2"
            return 0
        fi
    done

    echo -e "${ROSE}Impossible de set la variable $1 : La variariable n'éxiste pas !$END"
    return 1

}

# Delete var to the env
del() {
    REPL_var["$1"]=""
}

# display all var env
show() {
    echo -e "Variable enregistrer dans cette environnement : "
    for i in ${!REPL_var[@]}; do
        echo -e "     $BLUE $i =$YELLOW ${REPL_var["$i"]} $END"
    done
}

# execute tools
exec() {
    case $1 in
        nmap)
            if [[ "$2" == "IP" ]]; then
                # Execution de nmap pour le scan IP
                sudo nmap -sP ${REPL_var["TARGET"]}/${REPL_var["mask"]}
            else
                # Execution de NMAP avec les options -sS=TCP SYNK -sU=SCAN UDP -Pn=NO PING -v=verbose -O=detection OS -p=PORT
                sudo nmap -sS -sU -Pn -v -O -p ${REPL_var["PORT"]} ${REPL_var["TARGET"]} -oN ${REPL_var["OUTPUTFILE"]}
            fi
            ;;
        gobuster)
            if [[ "$2" == "dns" ]]; then
                gobuster dns -d ${REPL_var["TARGET"]} -t ${REPL_var["threads"]} -w ${REPL_var["wordlist_dns"]}
            elif [[ "$2" == "dir" ]]; then
                gobuster dir -k -u ${REPL_var["TARGET"]} -t ${REPL_var["threads"]} -w ${REPL_var["wordlist_dir"]} --random-agent -b 302,404 -d
            else
                echo -e "$RED $2 : PARAMETRE INCORRECT$END"
            fi
            ;;
        sqlmap)
            sqlmap -u ${REPL_var["TARGET"]} -a --dump-format ${REPL_var["output_dump"]}
            echo -e "\n\nVous pouvez voir la sortie du script ici : $PURPLE/home/$USER/.local/share/sqlmap/output/MONSITE.FR$END\n"
            ;;
        medusa)
            if [[ ${REPL_var["list_hosts"]} == "" ]]; then
                medusa -t 50 -h ${REPL_var["TARGET"]} -U ${REPL_var["list_users"]} -P ${REPL_var["list_password"]} -M ${REPL_var["module"]}
                return 0
            fi
            medusa -t 50 -H ${REPL_var["list_hosts"]} -U ${REPL_var["list_users"]} -P ${REPL_var["list_password"]} -M ${REPL_var["module"]}
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
    i=1
    allInstall=""
    while [[ $i -le $# ]]; do
        if [[ ${REPL_soft["$1"]} -eq 2 ]]; then
            allInstall="$allInstall $1"
        fi
        shift
    done
    echo -e "Installation de :$allInstall"
    sudo apt install$allInstall -y
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