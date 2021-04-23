
base64 -d <<<"H4sIAAAAAAAAA42OUQrAMAhD/wu9Qz43GHihgjvIDr8ZXbXsZwq1PJMgAGXhV4VyGvgpcM3pDRByqZrpWgOVWgwfO8wLlQKZY2K3PfFiGlRjGM5MSs4mw0UXWwmJq2T0ZkunptnMtwskZSvXZHY45D163YW7t8ElfEi8IfrwOsC7KLbKnCMTersBrGEE19sBAAA=" | gunzip
echo


function select_option {

    # little helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()  { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to()        { printf "$ESC[$1;${2:-1}H"; }
    print_option()     { printf "   $1 "; }
    print_selected()   { printf "  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()   { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()        { read -s -n3 key 2>/dev/null >&2
                         if [[ $key = $ESC[A ]]; then echo up;    fi
                         if [[ $key = $ESC[B ]]; then echo down;  fi
                         if [[ $key = ""     ]]; then echo enter; fi; }

    # initially print empty new lines (scroll down if at bottom of screen)
    for opt; do printf "\n"; done

    # determine current screen position for overwriting the options
    local lastrow=`get_cursor_row`
    local startrow=$(($lastrow - $#))

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local selected=0
    while true; do
        # print options by overwriting the last lines
        local idx=0
        for opt; do
            cursor_to $(($startrow + $idx))
            if [ $idx -eq $selected ]; then
                print_selected "$opt"
            else
                print_option "$opt"
            fi
            ((idx++))
        done

        # user key control
        case `key_input` in
            enter) break;;
            up)    ((selected--));
                   if [ $selected -lt 0 ]; then selected=$(($# - 1)); fi;;
            down)  ((selected++));
                   if [ $selected -ge $# ]; then selected=0; fi;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    return $selected
}


echo "Please select environment:"


options=("dev" "test" "int")

select_option "${options[@]}"
choice=$?

if [[ "$choice" == 2 ]]; then  
  SUB=" Development - Test"
  RG="rg000007"
  DB="int"
else
    if [[ "$choice" == 1 ]]; then
        SUB="Development - Test"
        
        echo "Please select environment:"
        echo
        options=("1" "2" "3" "4")
        select_option "${options[@]}"
        choice=$?
            
        if [[ "$choice" == 0 ]]; then
           RG="rg000012"
           DB="tst1"
        fi
        if [[ "$choice" == 1 ]]; then
           RG="rg000022"
           DB="tst2"
        fi
        if [[ "$choice" == 2 ]]; then
           RG="rg000032"
           DB="tst3"
        fi
        if [[ "$choice" == 3 ]]; then
           RG="rg000042"
           DB="tst4"
        fi
    fi
    if [[ "$choice" == 0 ]]; then
        SUB="Development - DEV"
        
        echo "Please select environment:"
        echo
        options=("1" "2" "3" "4")

        select_option "${options[@]}"
        choice=$?

        if [[ "$choice" == 0 ]]; then
           RG="rg000011"
           DB="dev1"
        fi
        if [[ "$choice" == 1 ]]; then
           RG="rg000021"
           DB="dev2"
        fi
        if [[ "$choice" == 2 ]]; then
           RG="rg000031"
           DB="dev3"
        fi
        if [[ "$choice" == 3 ]]; then
           RG="rg000041"
           DB="dev4"
        fi        
    fi
fi



echo "Subscription: $SUB"
echo "Resource group: $RG"
echo "CosmosDB account: $DB"
echo 
echo "Please login. Browser will appear in a sec..."
az login > /dev/null 2>&1

az account set --subscription "$SUB" > /dev/null 2>&1

# use bash curl
DESIRED_IP=$(curl ifconfig.me)
echo "your ip is: $DESIRED_IP"
# cinst -y jq
CURRENT_IPS=$( az cosmosdb list --resource-group "$RG" | jq -r '.[0].ipRules | .[] | .ipAddressOrRange' | sed ':a; N; $!ba; s/\n/,/g') > /dev/null 2>&1
echo "$DB ips: $CURRENT_IPS"
DESIRED_IPS=$CURRENT_IPS,$DESIRED_IP
echo "adding $DESIRED_IP to $DB..."
az cosmosdb update -n "$DB" -g "$RG" --ip-range-filter "$DESIRED_IPS" > /dev/null 2>&1


echo "(note) wait for 5 min approx to apply IP rules"

RED='\033[0;32m'
NC='\033[0m' # No Color
printf "${RED}done${NC}\n"
