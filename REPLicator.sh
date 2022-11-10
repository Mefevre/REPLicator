#!/bin/bash

#SET VAR SCRIPT
REPL_script_path="$(dirname $(readlink -f $0))/"
exit_mod=1
declare -A REPL_var=( ['mode']="" )
declare -A REPL_soft=(['nmap']=2 ['gobuster']=2 ['sqlmap']=2)

#COLOR VAR
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
ROSE='\033[1;31m'
WHITE='\033[0;37m'
YELLOW='\033[0;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
END='\033[m'

# REQUIREMENT
source $REPL_script_path/Sources/Center.sh
source $REPL_script_path/Sources/Prog_command.sh

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
if [[ "${REPL_var["mode"]}" = "" ]]; then
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
if [[ "${REPL_var["mode"]}" = "assiste" ]]; then

    echo "Set the different variables of this environment :"
    echo -n "Target => "
    read REPL_var["TARGET"]
    echo -n "Port => "
    read REPL_var["PORT"]

fi

# loop of prog
while [[ $exit_mod -eq 1 ]]; do
    echo -e -n "${REPL_var['mode_color']}`date '+%A %m %B %Y — %H:%M:%S'` $> $END"
    read -a REPLY
    comm=${REPLY[0]}
    unset REPLY[0]
    case $comm in
        set)
            set ${REPLY[@]} ;;
        del)
            del ${REPLY[@]} ;;
        show)
            show ;;
        exec)
            echo exec ;;
        list)
            list ${REPLY[@]} ;;
        install)
            install ${REPLY[@]} ;;
        help)
            echo help ;;
        mode)
            mode ;;
        meteo)
            echo meteo ;;
        cool)
            cool ;;
        q|exit|quit)
            exit_mod=0 ;;
        "")
            ;;
        *)
            echo -e "$ROSE Invalid arguments $END"
    esac
    if [[ "$comm" != "" ]]; then
        echo ""
    fi
done