#!/usr/bin/bash

# Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
purpleColour="\e[0;35m\033[1m"

#Variables
user=$(whoami)
dir=$(pwd)
fdir="$HOME/.local/share/fonts"


trap ctrl_c INT

function ctrl_c(){
    echo -e "\n\n${redColour}[!] Saliendo...\n${endColour}"
    exit 1
}

function banner(){
    echo "   __     ______   __"
    sleep 0.5
    echo "  / /    / __   | / /"
    sleep 0.5
    echo " / /____| | //| |/ /____"
    sleep 0.5
    echo "|___   _) |// | |___   _)"
    sleep 0.5
    echo "    | | |  /__| |   | |"
    sleep 0.5
    echo "    |_|  \_____/    |_|"
    sleep 0.5
    echo ".......................NotFound"
    sleep 1
}

if [ "$user" == "root" ]; then
    banner
    echo -e "\n\n${redColour}[X] Error no debes ejecutarlo como root!\n${endColour}"
    exit 1
else
    banner
    
    echo -e "\n${blueColour}[*] Instalanddo Oh My Zsh y Powerlevel10k para el usuario:${endColour} ${purpleColour}$user${endColour}${blueColour}...\n${endColour}"
    sleep 2
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${redColour}[X] Error al instalar Oh My Zsh y Powerlevel10k para el usuario:${endColour} ${purpleColour}$user${endColour}\n"
        exit 1
    else
        echo -e "\n${greenColour}[+] Realizado \n${endColour}"
        sleep 1.5
    fi
    
    echo -e "\n${blueColour}[*] Instalanddo Oh My Zsh y Powerlevel10k para el usuario root...\n${endColour}"
    sleep 2
    sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.oh-my-zsh/custom/themes/powerlevel10k
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${redColour}[X] Error al instalar Oh My Zsh y Powerlevel10k para el usuario root \n${endColour}"
        exit 1
    else
        echo -e "\n${greenColour}[+] Realizado \n${endColour}"
        sleep 1.5
    fi
    
    echo -e "\n${blueColour}[*] Instalando Fuente Hack Nerd Fonts\n${endColour}"
    sleep 0.5
    
    echo -e "\n${blueColour}[*] Configurando fuente...\n${endColour}"
    sleep 2
    if [[ -d "$fdir" ]]; then
        cp -rv $dir/fonts/* $fdir
    else
        mkdir -p $fdir
        cp -rv $dir/fonts/* $fdir
    fi
    echo -e "\n${greenColour}[+] Realizado\n${endColour}"
    sleep 1.5
    
    echo -e "\n${blueColour}[*] Configurando Archivos de .zshrc y .p10k.zsh...\n${endColour}"
    sleep 2
    cp -v $dir/.zshrc ~/.zshrc
    sudo ln -sfv ~/.zshrc /root/.zshrc
    cp -v $dir/.p10k.zsh ~/.p10k.zsh
    sudo ln -sfv ~/.p10k.zsh /root/.p10k.zsh
    echo -e "\n${greenColour}[+] Realizado\n${endColour}"
    sleep 1.5
    
    while true; do
        echo -en "\n${yellowColour}[?] Debes cerrar la terminal para aplicar los cambios quieres hacerlo ahora? ([y]/n) ${endColour}"
        read -r
        REPLY=${REPLY:-"y"}
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo -e "\n\n${greenColour}[+] Cerrando la terminal...\n${endColor}"
            sleep 2
            exit 0
            elif [[ $REPLY =~ ^[Nn]$ ]]; then
            exit 1
        else
            echo -e "\n${redColour}[!] Parametro invalido\n${endColour}"
        fi
    done
fi
