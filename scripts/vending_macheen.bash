#!/bin/bash
# Copyright (c) HashiCorp, Inc.


export HCLOGO="                                                  
                        ~5&:    .&5~              
                    :J#@@@@:    .@@@@B            
                .!G&@@@@@@@.    .@@@@@   .7.      
             ^5&@@@@@@@&P~      .@@@@@   ~@@&5^   
             @@@@@@@B7.   .:    .@@@@@   ^@@@@@   Welcome to ACME Vending Macheen!
             @@@@@J    !G&@:    .@@@@@   ^@@@@@   
             @@@@@~   @@@@@.    .@@@@@   ^@@@@@   - Coded by Senior Cloud Admin
             @@@@@~   @@@@@BPPPPG@@@@@   ^@@@@@   - Powered by HCP Terraform
             @@@@@~   @@@@@@@@@@@@@@@@   ^@@@@@   
             @@@@@~   @@@@@BPPPPB@@@@@   ^@@@@@   Please answer the workflow questions
             @@@@@~   @@@@@.    .@@@@@   ^@@@@@   to allocate the appropriate product 
             @@@@@~   @@@@@:    .@&G!    ?@@@@@   for your project.
             @@@@@~   @@@@@:    :'   .7G@@@@@@@   
             ^5&@@!   @@@@@:      ~5&@@@@@@@&5^   
                .7:   @@@@@:    .@@@@@@@&G7.      
                      B@@@@:    .@@@@#J:          
                        ~5&:    .&5~.             
                                                  "

ctype() {
    delay=0.0001
    string=$1
    len=${#string}

    for char in $(seq 0 $len); do
        printf "%c" "${string:$char:1}"
        sleep $delay
    done
    echo
}

cprint() {
  printf -- "$1%.s" $(eval "echo {1..$2}")
}

drawRow() {
  argc=$(echo "$#")  
  argv=${@}

  cprint " " 10
  cprint "|" 1
  for i in {1..3}
    do
      p=
      cprint "|" 1
      cprint "$1" 2
      if [ $argc -ge 2 ]; then
        note="$2-$i"

        if [ $argc -eq 3 ]; then
          p=$(( $2*$i ))
          note="\$ $p"
        fi

        len=${#note}
        max_padding=9
        padding=`expr $max_padding - $len`
        lpad=`expr $padding / 2`
        rpad=`expr $padding / 2`

        if [ $((padding%2)) -ne 0 ]; then
        #   ((lpad=lpad+1))
          ((rpad=rpad+1))
          amigdala=1
        fi

        cprint " " $lpad

        if [ $argc -eq 3 ]; then
          cprint "\$ $p" 1
        else
          cprint "$2-$i" 1
        fi
        
        cprint " " $rpad
      else
        cprint "$1" 3
      fi

      cprint "$1" 2
      cprint "|" 1
    done
  cprint "|" 1
  printf "\n"
}

cost_seed=$(echo $(( $RANDOM % 10 + 10 )))
montly_costs=$cost_seed

echo ""
echo ""

drawRows() {
  case $2 in
    "1")
      ENV="DEV"
      cost_seed=$(( $cost_seed * 1 ))
      ;;
    "2")
      ENV="QA"
      cost_seed=$(( $cost_seed * 2 ))
      ;;
    "3")
      ENV="PROD"
      cost_seed=$(( $cost_seed * 3 ))
      ;;
  esac

  drawRow "-=-"
  for i in $(seq 1 $1)
    do
      if [ $i -eq 2 ]; then
        drawRow "   " "$ENV"
      elif [ $i -eq 3 ]; then
        drawRow "   " "$cost_seed" 0
      else
        drawRow "   "
      fi
    done
}

clear
ctype "${HCLOGO}"

for i in {1..3}
  do
    drawRows 5 $i
  done

drawRow "___"

# This declares the scale
bunit=
ppurpose=

tput sc

echo ""
department=(Development CloudOps Marketing)
selected=()
PS3=$'\nPlease select your department: '
select name in "${department[@]}" ; do
    for reply in $REPLY ; do
        selected+=(${department[reply - 1]})
        bunit=$reply
    done
    [[ $selected ]] && break
done
echo Selected: "${selected[@]}"
echo ""
cprint " " 10
read -n 1 -s -r -p "Press any key to continue..."
printf '\r'; printf ' %0.s' {0..28}; printf '\n%.s' {1..2}

tput rc
tput ed

echo ""
description=("Feature Validation" "Load Testing" "Full Stack")
PS3=$'\nPlease select the description that matches your requirements: '
select name in "${description[@]}" ; do
    for reply in $REPLY ; do
        selected+=(${description[reply - 1]})
        ppurpose=$reply
    done
    [[ $selected ]] && break
done
echo Selected: "${selected[@]}"
echo ""
cprint " " 10
read -n 1 -s -r -p "Press any key to continue..."
printf '\r'; printf ' %0.s' {0..28}; printf '\n%.s' {1..2}

tput rc
tput ed

ENV=

case $bunit in
  "1")
    ENV="DEV"
    montly_costs=$(( $montly_costs * 1 ))
    ;;
  "2")
    ENV="QA"
    montly_costs=$(( $montly_costs * 2 ))
    ;;
  "3")
    ENV="PROD"
    montly_costs=$(( $montly_costs * 6 ))
    ;;
esac

montly_costs=$(( $montly_costs * $ppurpose ))
deployment_id=$(date +%s)
echo ""
echo ""
cprint " " 10
echo Description: "${selected[@]}"
cprint " " 10
echo Department: "${selected[0]}"
cprint " " 10
echo Purpose: "${selected[1]} ${selected[2]}"
cprint " " 10
echo "Product Stack: ${ENV}-${ppurpose}"
cprint " " 10
echo "Cost: $ ${montly_costs} per month"
cprint " " 10
echo "Deployment ID: ${deployment_id}"
echo ""
echo ""

GENERATOR_DIR="/root/terraform-api"
TARGET_FILE="list_of_deployments.json"
DEPLOYMENT_FILE="deployment_${deployment_id}.json"

cat << EOF > "${GENERATOR_DIR}/${DEPLOYMENT_FILE}"
{
  "Description" : "${selected[@]}",
  "Department" : "${selected[0]}",
  "Environment" : "${ENV}",
  "Purpose" : "${selected[1]} ${selected[2]}",
  "Product Stack" : "${ENV}-${ppurpose}",
  "Deployment ID" : "${deployment_id}"
}
EOF

read -p "Do you want to build this now? Only 'y' or 'Y' will be accepted to confirm. " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

cd $GENERATOR_DIR

jq --argjson deployment "$(cat $DEPLOYMENT_FILE)" '. +=[$deployment]' $TARGET_FILE > temp_$TARGET_FILE
mv temp_$TARGET_FILE $TARGET_FILE
rm -f $DEPLOYMENT_FILE

terraform init --upgrade
terraform apply -auto-approve
terraform apply -auto-approve -refresh-only
clear
terraform output -json vending_machine_workspaces \
| jq --arg deployment_id "$deployment_id" '.[] | select(.tag_names[] | select(. == $deployment_id))'
