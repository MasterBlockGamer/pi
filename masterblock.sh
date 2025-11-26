#!/bin/bash

# MasterBlock Mathematical Animation
# Ultra cool math art with animations

# Colors
GREEN='\033[0;32m'
BLACK='\033[0;30m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Animation functions
typewriter() {
    text=$1
    color=$2
    delay=$3
    
    echo -ne "${color}"
    for (( i=0; i<${#text}; i++ )); do
        echo -n "${text:$i:1}"
        sleep $delay
    done
    echo -e "${NC}"
}

show_loading_animation() {
    echo -e "${BLUE}Initializing MasterBlock System..."
    frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    for i in {1..20}; do
        frame=${frames[$i % ${#frames[@]}]}
        echo -ne "${CYAN}${frame} Calculating mathematical constants...${NC}\r"
        sleep 0.1
    done
    echo -e "${GREEN}✓ Mathematical matrix stabilized!${NC}"
    sleep 1
}

show_masterblock_header() {
    clear
    echo ""
    echo -e "${BLUE}╔══════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                  ${WHITE}MASTERBLOCK${BLUE}                   ║${NC}"
    echo -e "${BLUE}║           ${CYAN}you are now in masterblock's space${BLUE}         ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════╝${NC}"
    echo ""
}

show_mathematical_creeper() {
    # Animate the creeper appearing
    for i in {1..5}; do
        case $i in
            1)
                echo -e "${GREEN}        █████████████████       ${NC}"
                ;;
            2)
                echo -e "${GREEN}        █████████████████       ${NC}"
                echo -e "${GREEN}      ██  ${MAGENTA}½${GREEN}  ${MAGENTA}⅓${GREEN}  ${MAGENTA}¼${GREEN}  ${MAGENTA}⅕${GREEN}  ██     ${NC}"
                ;;
            3)
                echo -e "${GREEN}        █████████████████       ${NC}"
                echo -e "${GREEN}      ██  ${MAGENTA}½${GREEN}  ${MAGENTA}⅓${GREEN}  ${MAGENTA}¼${GREEN}  ${MAGENTA}⅕${GREEN}  ██     ${NC}"
                echo -e "${GREEN}    ██  ${MAGENTA}⅙${GREEN}  ${MAGENTA}⅐${GREEN}  ${MAGENTA}⅛${GREEN}  ${MAGENTA}⅑${GREEN}  ${MAGENTA}⅒${GREEN}  ██   ${NC}"
                ;;
            4)
                echo -e "${GREEN}        █████████████████       ${NC}"
                echo -e "${GREEN}      ██  ${MAGENTA}½${GREEN}  ${MAGENTA}⅓${GREEN}  ${MAGENTA}¼${GREEN}  ${MAGENTA}⅕${GREEN}  ██     ${NC}"
                echo -e "${GREEN}    ██  ${MAGENTA}⅙${GREEN}  ${MAGENTA}⅐${GREEN}  ${MAGENTA}⅛${GREEN}  ${MAGENTA}⅑${GREEN}  ${MAGENTA}⅒${GREEN}  ██   ${NC}"
                echo -e "${GREEN}    ██  ${MAGENTA}½${GREEN}  ${BLACK}██████${GREEN}  ${MAGENTA}⅒${GREEN}  ██   ${NC}"
                echo -e "${GREEN}    ██  ${MAGENTA}⅓${GREEN}  ${BLACK}██████${GREEN}  ${MAGENTA}⅑${GREEN}  ██   ${NC}"
                ;;
            5)
                # Full creeper
                echo -e "${GREEN}        █████████████████       ${NC}"
                echo -e "${GREEN}      ██  ${MAGENTA}½${GREEN}  ${MAGENTA}⅓${GREEN}  ${MAGENTA}¼${GREEN}  ${MAGENTA}⅕${GREEN}  ██     ${NC}"
                echo -e "${GREEN}    ██  ${MAGENTA}⅙${GREEN}  ${MAGENTA}⅐${GREEN}  ${MAGENTA}⅛${GREEN}  ${MAGENTA}⅑${GREEN}  ${MAGENTA}⅒${GREEN}  ██   ${NC}"
                echo -e "${GREEN}    ██  ${MAGENTA}½${GREEN}  ${BLACK}██████${GREEN}  ${MAGENTA}⅒${GREEN}  ██   ${NC}"
                echo -e "${GREEN}    ██  ${MAGENTA}⅓${GREEN}  ${BLACK}██████${GREEN}  ${MAGENTA}⅑${GREEN}  ██   ${NC}"
                echo -e "${GREEN}    ██  ${MAGENTA}¼${GREEN}  ${MAGENTA}⅕${GREEN}  ${MAGENTA}⅙${GREEN}  ${MAGENTA}⅐${GREEN}  ${MAGENTA}⅛${GREEN}  ██   ${NC}"
                echo -e "${GREEN}    ██  ${BLACK}████${GREEN}  ${MAGENTA}∑${GREEN}  ${MAGENTA}π${GREEN}  ${BLACK}████${GREEN}  ██   ${NC}"
                echo -e "${GREEN}      ██  ██████████████  ██     ${NC}"
                echo -e "${GREEN}        █████████████████       ${NC}"
                ;;
        esac
        sleep 0.5
    done
    echo ""
}

show_math_equations() {
    echo -e "${YELLOW}Solving MasterBlock equations...${NC}"
    sleep 1
    
    equations=(
        "${MAGENTA}½ + ⅓ = ⅚${NC}"
        "${CYAN}¼ + ⅕ = ⁹⁄₂₀${NC}"
        "${GREEN}⅙ + ⅐ = ¹³⁄₄₂${NC}"
        "${BLUE}⅛ + ⅑ = ¹⁷⁄₇₂${NC}"
        "${RED}⅒ + ∞ = ∞${NC}"
        "${MAGENTA}∑(½ⁿ) = 1${NC}"
    )
    
    for eq in "${equations[@]}"; do
        echo -e "$eq"
        sleep 0.7
    done
    echo ""
}

show_masterblock_summary() {
    echo -e "${CYAN}⚡ MASTERBLOCK SYSTEM STATUS:${NC}"
    sleep 0.5
    
    echo -e "${WHITE}┌─ MATHEMATICAL ENGINES${NC}"
    sleep 0.3
    echo -e "${WHITE}│  Python³ + NumPy + OpenCV + SciPy${NC}"
    sleep 0.3
    echo -e "${WHITE}├─ COMPUTATIONAL MATRIX${NC}"
    sleep 0.3
    echo -e "${WHITE}│  Java + Node.js + Qt + GCC${NC}"
    sleep 0.3
    echo -e "${WHITE}├─ VIRTUAL ENVIRONMENTS${NC}"
    sleep 0.3
    echo -e "${WHITE}│  ~/venvs/{cv,web,ml,general}${NC}"
    sleep 0.3
    echo -e "${WHITE}└─ PROJECT DIMENSIONS${NC}"
    sleep 0.3
    echo -e "${WHITE}   ~/projects/{python,java,web,scripts,testing,qt}${NC}"
    echo ""
    sleep 1
    
    echo -e "${YELLOW}🎯 MASTERBLOCK COMMANDS:${NC}"
    sleep 0.5
    echo -e "${WHITE}py - activate python computational engine${NC}"
    sleep 0.3
    echo -e "${WHITE}jupyter-lab - launch interactive math notebook${NC}"
    sleep 0.3
    echo -e "${WHITE}source ~/.bashrc - reload masterblock settings${NC}"
    echo ""
    sleep 1
    
    echo -e "${MAGENTA}∫ MASTERBLOCK EQUATION SOLVED:${NC}"
    typewriter "½ + ⅓ + ¼ + ... = ∞ POSSIBILITIES!" "$GREEN" 0.1
    echo ""
    
    echo -e "${BLUE}▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄${NC}"
    echo -e "${CYAN}   SYSTEM READY - WELCOME TO MASTERBLOCK'S SPACE${NC}"
    echo -e "${BLUE}▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀${NC}"
    echo ""
}

# Main execution sequence
main() {
    show_loading_animation
    sleep 1
    show_masterblock_header
    sleep 1
    show_mathematical_creeper
    sleep 1
    show_math_equations
    sleep 1
    show_masterblock_summary
}

# Run the masterpiece
main "$@"
