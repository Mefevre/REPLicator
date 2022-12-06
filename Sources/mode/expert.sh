expert() {
    echo -e -n "${REPL_var['mode_color']}`date '+%A %m %B %Y — %H:%M:%S'` $> $END"
    read -a REPLY
    echo "${REPLY[@]}" >> $REPL_script_path/Sources/.history
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
            exec ${REPLY[@]} ;;
        list)
            list ${REPLY[@]} ;;
        install)
            install ${REPLY[@]} ;;
        help)
            help ${REPLY[@]} ;;
        mode)
            mode ;;
        meteo)
            meteo ${REPLY[@]} ;;
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
}