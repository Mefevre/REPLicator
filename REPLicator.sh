#!/bin/bash

#SET VAR SCRIPT
REPL_script_path="$(dirname $(readlink -f $0))/"

# REQUIREMENT
source $REPL_script_path/Sources/Center.sh
source $REPL_script_path/Sources/Prog_command.sh
REPL_mode=""

# Select mode with options
while [[ $# -gt 0 ]]; do
    case $1 in
        -e) 
            center "$  Expert Mode  $"
            REPL_mode="expert"
            shift
            ;;
        -a) 
            center "$  Assisté Mode  $"
            REPL_mode="assiste"
            shift
            ;;
        *) 
            echo "Unknown parameter : $1"
            exit 1
            ;;
    esac
done

if [[ "$REPL_mode" = "" ]]; then
    loop_mode=1
    while [[ $loop_mode -eq 1 ]]; do

        echo "Vous entrez dans REPLicator ! "
        echo "Veuillez-vous choisir un mode d'execution pour REPLicator :" 
        echo "
        1. Expert Mode
        2. Assisté Mode
        "
        echo "Vous pouvez lancer le programme avec les commandes \"./REPLicator -a\" pour le mode assisté et \"REPLicator -e\" pour le mode expert."
        echo -n "[Default 2] : "
        read
        case $REPLY in
            1)
                center "$  Expert Mode  $"
                REPL_mode="expert"
                loop_mode=0
                ;;
            2 | "")
                center "$  Assisté Mode  $"
                REPL_mode="assiste"
                loop_mode=0
                ;;
            *)
                echo "Entrée incorrect : $REPLY"
                ;;
        esac
    done
fi

if [[ "$REPL_mode" = "assiste" ]]; then

    echo "Set the different variables of this environment :"
    echo -n "Target => "
    read REPL_var_TARGET
    echo -n "other => "
    read REPL_var_

fi