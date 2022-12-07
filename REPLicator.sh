#!/bin/bash

#SET VAR SCRIPT
VERSION="1.0.0"
REPL_script_path="$(dirname $(readlink -f $0))"
exit_mod=1
declare -A REPL_var=( ['mode']="" ['OUTPUTFILE']="/dev/null" ['output_dump']="html" ['wordlist_dir']="$REPL_script_path/Sources/SecLists-master/Discovery/Web-Content/common.txt" ['wordlist_dns']="$REPL_script_path/Sources/SecLists-master/Discovery/DNS/shubs-subdomains.txt" ['threads']="100" ['mask']="24" ['TARGET']="" ['PORT']="" ['list_hosts']="" ['list_users']="$REPL_script_path/Sources/SecLists-master/Usernames/top-usernames-shortlist.txt" ['list_password']="$REPL_script_path/Sources/SecLists-master/Passwords/Common-Credentials/best1050.txt" ['module']="ssh" )
declare -A REPL_soft=( ['nmap']=2 ['gobuster']=2 ['sqlmap']=2 ['medusa']=2 )

#COLOR VAR
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
ROSE='\033[1;31m'
WHITE='\033[0;37m'
YELLOW='\033[0;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BLACK='\033[0;30m'
END='\033[m'

# REQUIREMENT
source $REPL_script_path/Sources/Center.sh
source $REPL_script_path/Sources/Prog_command.sh
source $REPL_script_path/Sources/ToLower.sh
source $REPL_script_path/Sources/mode/expert.sh
source $REPL_script_path/Sources/mode/assiste.sh

# Bannier bvn
echo ""
figlet "REPLicator" | lolcat
echo -n "     version : " | lolcat
echo "$VERSION"
echo -n "     Sources : " | lolcat
echo "https://github.com/Mefevre/REPLicator"
echo "
------------------------------------------------------
" | lolcat

# get option with her parameter
while [[ $# -gt 0 ]]; do
    case $1 in
        -e) 
            center "$RED $   Expert Mode   $ $END"
            REPL_var["mode"]="expert"
            REPL_var["mode_color"]=$RED
            shift
            ;;
        -a) 
            center "$GREEN $   Assisté Mode   $ $END"
            REPL_var["mode"]="assiste"
            REPL_var["mode_color"]=$GREEN
            shift
            ;;
        *) 
            echo "Unknown parameter : $1"
            exit 1
            ;;
    esac
done

# set mode if not set
if [[ "${REPL_var["mode"]}" == "" ]]; then
    # init var loop for have an answer of user
    loop_mode=1
    while [[ $loop_mode -eq 1 ]]; do

        # Menu of select MODE
        echo "Vous entrez dans REPLicator ! "
        echo "Veuillez-vous choisir un mode d'execution pour REPLicator :" 
        echo "
        1. Expert Mode
        2. Assisté Mode
        "
        echo "Vous pouvez lancer le programme avec les commandes \"./REPLicator -a\" pour le mode assisté et \"REPLicator -e\" pour le mode expert."
        echo -n "[Default 2] : "
        # Wait enter user
        read
        case $REPLY in
            1)
                center "$RED $   Expert Mode   $ $END"
                REPL_var["mode"]="expert"
                REPL_var["mode_color"]=$RED
                loop_mode=0
                ;;
            2 | "")
                center "$GREEN $   Assisté Mode   $ $END"
                REPL_var["mode"]="assiste"
                REPL_var["mode_color"]=$GREEN
                loop_mode=0
                ;;
            *)
                echo "Entrée incorrect : $REPLY"
                ;;
        esac
    done
fi

# assistance for set basic var of the env
if [[ "${REPL_var["mode"]}" == "assiste" ]]; then

    echo "Set the different variables of this environment :"
    echo -e -n "$YELLOW Target =>$END "
    read REPL_var["TARGET"]
    echo -e -n "$YELLOW Port =>$END "
    read REPL_var["PORT"]
    echo -e -n "$YELLOW Fichier de sortie [/dev/null] =>$END "
    read
    if [[ $REPLY != "" ]]; then
        REPL_var["OUTPUTFILE"]=$REPLY
    fi

fi

# loop of prog
while [[ $exit_mod -eq 1 ]]; do
    if [[ "${REPL_var['mode']}" == "expert" ]]; then
        expert
    else
        assiste
    fi
done
