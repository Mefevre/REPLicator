assiste() {
    echo -e "Action disponnibles :

    1 - parametrer une variable
    2 - supprimer une variable
    3 - affichier toutes les variables
    4 - lancer un programme
    5 - lister les programmes installés
    6 - installer un programme
    7 - afficher l'aide
    8 - changer de mode
    9 - affichier la meteo local
    10 - ...
    q - quitter le programme
    "

    echo -e -n "${REPL_var['mode_color']}Entrée le numéro de votre choix $> $END"
    read -a REPLY
    echo "${REPLY[@]}" >> $REPL_script_path/Sources/.history
    comm=${REPLY[0]}
    unset REPLY[0]
    case $comm in
        1)
            set ${REPLY[@]} ;;
        2)
            del ${REPLY[@]} ;;
        3)
            show ;;
        4)
            exec ${REPLY[@]} ;;
        5)
            list ${REPLY[@]} ;;
        6)
            install ${REPLY[@]} ;;
        7)
            help ${REPLY[@]} ;;
        8)
            mode ;;
        9)
            meteo ${REPLY[@]} ;;
        10)
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
}