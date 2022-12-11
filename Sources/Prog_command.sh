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
    if [[ "`toLower $1`" == "mode" ]]; then
        echo -e "${ROSE}Impossible de supprimer la variable MODE : Autorisation non permise !$END"
        return 1
    fi
    for i in ${!REPL_var[@]}; do
        if [[ "`toLower $1`" == "`toLower $i`" ]];then
            REPL_var["$1"]=""
            echo -e "La variable ${GREEN}$i ${WHITE}a bien été$GREEN supprimée$END"
            return 0
        fi
    done
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
                sudo nmap -sP ${REPL_var["TARGET"]}/${REPL_var["mask"]} -oN ${REPL_var["OUTPUTFILE"]}
            else
                # Execution de NMAP avec les options -sS=TCP SYNK -sU=SCAN UDP -sV=version service -Pn=NO PING -v=verbose -O=detection OS -p=PORT
                sudo nmap -sS -sV -Pn -v -O -p ${REPL_var["PORT"]} ${REPL_var["TARGET"]} -oN ${REPL_var["OUTPUTFILE"]}
            fi
            ;;
        gobuster)
            if [[ "$2" == "dns" ]]; then
                gobuster dns -d ${REPL_var["TARGET"]} -t ${REPL_var["threads"]} -w ${REPL_var["wordlist_dns"]} -o ${REPL_var["OUTPUTFILE"]}
            else
                gobuster dir -k -u ${REPL_var["TARGET"]} -t ${REPL_var["threads"]} -w ${REPL_var["wordlist_dir"]} --random-agent -b 302,404 -d -o ${REPL_var["OUTPUTFILE"]}
            fi
            ;;
        sqlmap)
            sqlmap -u ${REPL_var["TARGET"]} -a --dump-format ${REPL_var["output_dump"]}
            echo -e "\n\nVous pouvez voir la sortie du script ici : $PURPLE/home/$USER/.local/share/sqlmap/output/MONSITE.FR$END\n"
            ;;
        medusa)
            if [[ ${REPL_var["list_hosts"]} == "" ]]; then
                medusa -t ${REPL_var["threads"]} -h ${REPL_var["TARGET"]} -U ${REPL_var["list_users"]} -P ${REPL_var["list_password"]} -M ${REPL_var["module"]} -O ${REPL_var["OUTPUTFILE"]}
                return 0
            fi
            medusa -t ${REPL_var["threads"]} -H ${REPL_var["list_hosts"]} -U ${REPL_var["list_users"]} -P ${REPL_var["list_password"]} -M ${REPL_var["module"]} -O ${REPL_var["OUTPUTFILE"]}
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
                echo -e "   -$BLUE $i               $GREEN[INSTALLED]$END"
            fi
        done
    else
        echo -e "list of compatible programs : "
        for i in ${!REPL_soft[@]}; do
            if [[ ${REPL_soft["$i"]} -ne 0 ]]; then
                echo -e -n "   -$BLUE $i    $END6"
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
    figlet "REPLicator v$VERSION " | lolcat
    echo -e "
Usage : 
    $PURPLE COMMAND$YELLOW <$BLUE programme $YELLOW> <$BLUE option $YELLOW>$END
    $PURPLE COMMAND$YELLOW <$BLUE parametre $YELLOW>$END

COMMAND :
    $PURPLE SET$CYAN : Editer la valeur d'une variable$END
    $PURPLE DEL$CYAN : Supprimer la valeur d'une variable$END
    $PURPLE SHOW$CYAN : Afficher toutes les variables$END
    $PURPLE EXEC$CYAN : Executer un programme issue de la liste$END
    $PURPLE LIST$CYAN : Lister les programmes compatiblent$END
    $PURPLE INSTALL$CYAN : Installer un programme géré par le script$END
    $PURPLE HELP$CYAN : Afficher l'aide$END
    $PURPLE MODE$CYAN : Changer d'expériance utilisateur (assité <=> expert)$END
    $PURPLE METEO$CYAN : Affichier ma méteo local$END
    $PURPLE COOL$CYAN : ...$END
    $PURPLE q | exit | quit$CYAN : Quitter le programme$END

PROGRAMMES
    $BLUE NMAP $YELLOW<OPTION>$END
        option:
            - $YELLOW PORT$CYAN : Effectue un scan sur les ports d'un hote$END $GREEN (default)$END 
            - $YELLOW IP$CYAN : Effectue un scan sur un reseau IP$END
    $BLUE GODUSTER $YELLOW<OPTION>$END
        option
            - $YELLOW DIR$CYAN : Effectue une découverte de l'arborescence d'un site $END $GREEN (default)$END 
            - $YELLOW DNS$CYAN : Effectue une découverte des sous-domaine DNS$END
    $BLUE SQLMAP$CYAN : Scanne une BDD et remonte les failles a partir d'une URL$END
    $BLUE MEDUSA$CYAN : Effectue un brut force sur différnates méthodes d'authentification (SSh, RDP, ...)$END

VARIABLE D'ENVIRONEMENT
    $YELLOW TARGET$CYAN => Cible de l'attaque
    $YELLOW PORT$CYAN => Port ou plange de port
    $YELLOW OUTPUTFILE$CYAN => Fichier de sortie des programmes
    $YELLOW mode$CYAN => Mode d'execution du programme$END
    du programme NMAP
        $YELLOW masque reseau$CYAN => Masque du sous reseau$GREEN (default : 24)$END
    du programme SQLMAP
        $YELLOW output_dump$CYAN => Format de sortie du fichier dump$GREEN (default : html)$END
    du programme GOBUSTER
        $YELLOW wordlist_dir$CYAN => Fichier d'entrée de wordlist$GREEN (default : ./Sources/SecLists-master/Discovery/Web-Content/common.txt)
        $YELLOW wordlist_dns$CYAN => Fichier d'entrée de wordlist$GREEN (default : ./Sources/SecLists-master/Discovery/DNS/shubs-subdomains.txt)
        $YELLOW threads$CYAN => Nombre threads par processus$END
    du programme MEDUSA
        $YELLOW module$CYAN => Nom du module a utilisé$GREEN (default : ssh)
        $YELLOW list_hosts$CYAN => Fichier d'entrée d'hotes
        $YELLOW list_users$CYAN => Fichier d'entrée d'utilisateurs$GREEN (default : ./Sources/SecLists-master/Usernames/Honeypot-Captures/multiplesources-users-fabian-fingerle.de.txt)
        $YELLOW list_password$CYAN => Fichier d'entrée de mot de passe$GREEN (default : ./Sources/Sources/SecLists-master/Passwords/Honeypot-Captures/multiplesources-passwords-fabian-fingerle.de.txt)$END
    
EXEMPLE
    exec nmap
    list 
    list gobuster
    install sqlmap
    set TARGET monsite.fr
    del PORT
    exec gobuster DNS
    "
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