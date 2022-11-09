center ()
{
    termwidth="$(tput cols)";
    padding="$(printf '%0.1s' ={1..500})";
    echo -e $1 | printf '%*.*s %s %*.*s\n' 0 "$((((termwidth-2-${#1})/2)-2))" "$padding" "  $(cat /dev/stdin)  " 0 "$((((termwidth-1-${#1})/2)-2))" "$padding"
}