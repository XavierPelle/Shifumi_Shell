#!/bin/bash

menu_game(){

echo "Bienvenue sur SHIFUMI 2000"
read -p "Choississez le nombre de joueurs : (1/2) : " NBJOUEUR
read -p "Choississez le nom du premier joueur : " J1
if [[ "$NBJOUEUR" == "2" ]]; then
    read -p "Choississez le nom du deuxieme joueur : " J2
else
    J2="BOT" 
fi
read -p "Choississez le nombre de tour : " NBTOUR
read -p "Est ce que vous voulez jouer avec le puit ? (y/n)" PUIT
echo "Le jeu commence, c'est une partie en $NBTOUR tours"
sleep 2
clear
}

solo_game() {
    if [[ "$PUIT" == "y" ]]; then 
        bot_choice=("p" "f" "c" "u")
    else  
        bot_choice=("p" "f" "c")
    fi
}

compare_choices(){

        case "$J1_CHOICE" in
        p ) 
            case $J2_CHOICE in 
                p) echo "$J1 : $J1_CHOICE et $J2 : $J2_CHOICE -- Match nul";;
                f) echo "$J1 : $J1_CHOICE et $J2 : $J2_CHOICE -- $J2 gagne!"; ((score_J2++));;
                c) echo "$J1 : $J1_CHOICE et $J2 : $J2_CHOICE -- $J1 gagne!"; ((score_J1++));;
                u) echo "$J1 : $J1_CHOICE et $J2 : $J2_CHOICE -- $J2 gagne!"; ((score_J2++));;
            esac
            ;;
        f ) 
            case $J2_CHOICE in
                p) echo "$J1 : $J1_CHOICE et $J2 : $J2_CHOICE -- $J1 gagne!"; ((score_J1++));;
                f) echo "$J1 : $J1_CHOICE et $J2 : $J2_CHOICE -- Match nul";;
                c) echo "$J1 : $J1_CHOICE et $J2 : $J2_CHOICE -- $J2 gagne!"; ((score_J2++));;
                u) echo "$J1 : $J1_CHOICE et $J2 : $J2_CHOICE -- $J1 gagne!"; ((score_J1++));;
            esac
            ;;
        c)
            case $J2_CHOICE in
                p) echo "$J1 : $J1_CHOICE et $J2 : $J2_CHOICE -- $J2 gagne!"; ((score_J2++));;
                f) echo "$J1 : $J1_CHOICE et $J2 : $J2_CHOICE -- $J1 gagne!"; ((score_J1++));;
                c) echo "$J1 : $J1_CHOICE et $J2 : $J2_CHOICE -- Match nul";;
                u) echo "$J1 : $J1_CHOICE et $J2 : $J2_CHOICE -- $J2 gagne!"; ((score_J2++));;
            esac
            ;;
        u) 
            case $J2_CHOICE in
                p) echo "$J1 : $J1_CHOICE et $J2 : $J2_CHOICE -- $J2 gagne!"; ((score_J1++));;
                f) echo "$J1 : $J1_CHOICE et $J2 : $J2_CHOICE -- $J1 gagne!"; ((score_J2++));;
                c) echo "$J1 : $J1_CHOICE et $J2 : $J2_CHOICE -- $J1 gagne!"; ((score_J2++));;
                u) echo "$J1 : $J1_CHOICE et $J2 : $J2_CHOICE -- Match nul";;
            esac
        esac
}

start_game(){

    score_J1=0 ;
    score_J2=0 ;

    for ((i=1; i <= $NBTOUR; i++)) do

        echo "C'est le tour $i sur $NBTOUR"
            if [[ "$PUIT" == "y" ]]; then 
                echo "Vous pouvez choisir entre Pierre (p) Feuille (f) Ciseaux (c) Puit (u)"
            else  
                echo "Vous pouvez choisir entre Pierre (p) Feuille (f) Ciseaux (c)"
            fi
        echo "Voici les scores actuelle $J1 à $score_J1 points et $J2 à $score_J2 points"

        while true; do
            read -s -p "$J1 doit choisir un signe : " J1_CHOICE
            echo ""
            case $J1_CHOICE in
                p|f|c) break;;
                u) if [[ "$PUIT" == "y" ]]; then break; else echo "Le puit n'est pas activé"; fi ;;
                *) echo "Choix non valide."
            esac
        done
        if [[ "$NBJOUEUR" == "1" ]]; then
            index=$((RANDOM % ${#bot_choice[@]}))
            J2_CHOICE=${bot_choice[$index]}
            echo "$J2 a choisi : $J2_CHOICE"
        else
        while true; do
            read -s -p "$J2 doit choisir un signe : " J2_CHOICE
            echo ""
            case $J2_CHOICE in
                p|f|c) break;;
                u) if [[ "$PUIT" == "y" ]]; then break; else echo "Le puit n'est pas activé"; fi ;;
                *) echo "Choix non valide."
            esac
        done
    fi
        compare_choices $J1_CHOICE $J2_CHOICE
    done

    win_game $score_J1 $score_J2 
    
}

win_game(){

    clear

    if (( $score_J1 > $score_J2)) then
        echo "$J1 Gagne !"
    elif (( $score_J2 > $score_J1)) then
        echo "$J2 Gagne !"
    else
        echo "Match nul ! "
    fi

}

init_game(){

    menu_game
    if [[ "$NBJOUEUR" == "1" ]]; then 
        solo_game; 
        start_game
    else
        start_game
    fi

}

init_game