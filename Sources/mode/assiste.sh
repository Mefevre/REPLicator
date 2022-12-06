control_var() {
    tmp=1
            echo -e "Liste des variables disponnibles : "
            for i in ${!REPL_var[@]}; do
                echo "      $tmp - $i"
                tmp=$((tmp+1))
            done
            echo -e -n "Entrée le numéro de la variable : "
            read var
            case $var in
                1)
                    var="mode_color";;
                2)
                    var="mask";;
                3)
                    var="list_users";;
                4)
                    var="list_hosts";;
                5)
                    var="threads";;
                6)
                    var="PORT";;
                7)
                    var="list_password";;
                8)
                    var="OUTPUTFILE";;
                9)
                    var="wordlist_dir";;
                10)
                    var="wordlist_dns";;
                12)
                    var="output_dump";;
                13)
                    var="module";;
                14)
                    var="TARGET";;
                *)
                    echo -e "$ROSE Entree interdite !$END"
                    return 1
            esac
}
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
            control_var
            echo -e -n "Entrée la nouvelle valeur de cette variable : "
            read val
            set $var $val ;;
        2)
            control_var
            del $var ;;
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