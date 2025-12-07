#!/bin/bash

# ==========================================
# Xandminer Hardened Installer
# Security Fixes Applied: Dec 2025 @wagisdev -- Yeah, that @wagisdev!
# ==========================================

# Parse command-line arguments for dev mode
DEV_MODE=false
for arg in "$@"; do
    if [ "$arg" = "-d" ]; then
        DEV_MODE=true
        break
    fi
done

# SECURITY FIX: Install to /opt instead of /root to allow non-privileged execution
INSTALL_BASE="/opt"
XANDMINER_DIR="$INSTALL_BASE/xandminer"
XANDMINERD_DIR="$INSTALL_BASE/xandminerd"

cat <<"EOF"
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠄⡂⠌⠄⠅⠅⡂⢂⠂⡂⠂⡂⢐⠀⡂⢐⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠊⢔⠐⠌⠌⠌⢌⠐⠄⠅⢂⠂⠡⢐⢀⢂⠐⠠⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠤⡀⡄⡄⢄⠤⡀⡄⡄⡠⡠⡠⡠⡠⡠⢠⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢔⠡⡊⠔⡡⠡⡡⢑⠄⠅⠅⠅⠢⠨⢈⠄⠂⠄⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⢌⢊⢢⠱⠨⡂⡪⡐⠔⢔⠰⡐⠌⡂⠢⠡⢑⢐⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠢⡊⡢⡑⢌⢌⠢⡑⡐⡡⠨⠨⡨⠨⠨⠨⢐⠈⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠢⡑⢅⠕⡰⢈⠪⡐⠡⢂⢑⠨⠨⠨⢐⠐⡈⡐⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢐⢌⢎⠢⡑⡌⡢⠢⡑⠔⠌⢔⠡⡑⠄⢅⠅⡑⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠢⡑⠌⡂⠕⠨⡈⡂⡂⠅⡡⢁⠂⡂⡐⠠⠐⠈⠀⠀⠀⠀⠀⠀⠀⢀⢔⢜⢌⢆⢕⢅⠣⡪⢨⢊⢌⠪⡘⢄⠕⡐⠅⠅⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠌⠔⠡⢑⢐⠐⠄⠅⢂⠐⡐⠠⠐⢈⢀⠁⡈⠐⡀⡀⠀⠀⠀⠑⡕⡕⡜⡔⢕⠜⡌⡪⢢⠱⡐⠕⡌⡢⡑⠌⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⢑⢐⠐⠨⠠⢁⠂⢂⠐⡀⠅⠠⠀⠄⠐⡀⢂⢐⠠⠀⠀⠈⠸⡸⡨⡪⡪⡊⡎⡜⢔⡑⡅⢇⢪⠰⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠈⠌⢐⠠⢈⠠⠐⢀⠐⠀⠂⡀⠁⠄⢂⠐⡈⠌⡀⡀⠀⠈⠘⡜⡜⡜⡌⡎⢆⢣⢊⠎⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠐⡀⠄⠐⠀⠄⠀⢁⠠⠀⠂⠨⠀⡂⠂⠅⠢⠨⡠⠀⠀⠀⠑⢕⢕⢪⢪⠪⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠁⠐⠀⠈⠀⠀⠠⠈⠄⠡⠠⠡⠡⠡⡑⠄⢕⠠⠀⠀⠀⠑⡕⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡈⢂⠐⠀⠂⠈⢀⠈⠄⠁⠌⠠⠡⡈⠢⡨⡈⡢⠈⠀⠀⢀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢂⠐⡀⠄⠠⠀⠂⠠⠐⠈⠠⠁⠌⡐⡈⡂⡂⠂⠀⠀⠀⠐⠀⠀⠄⠐⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠡⢐⠀⡂⠄⠂⢂⠐⠀⠂⡀⠡⠈⠄⡁⢂⢂⠂⠀⠀⠀⠐⠀⡀⠂⢁⠠⠁⡐⠠⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⡂⠅⡡⢁⠂⡂⡐⡈⢐⠠⠈⠄⢁⠠⠐⢈⠀⡂⠂⠀⠀⠀⠠⠈⠀⠂⡀⠂⠄⠂⡁⠄⠌⢐⠀⠅⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⡂⡂⡢⢁⢂⠂⢅⢐⢀⠂⡂⠄⠅⠨⠀⠄⠂⡀⠂⠀⠀⠀⠀⠈⡀⢀⠡⠐⠀⠌⠠⠁⠄⠂⠌⠄⠌⡨⠐⡐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⡢⢂⠪⡐⡐⡡⠂⢅⢂⢂⠂⢌⠐⡈⠄⠅⠌⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠄⠐⡈⠄⠡⠁⠌⠄⡑⡈⠄⠅⡂⠅⡂⠅⢅⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢆⠪⡐⢅⠕⡐⢅⠢⡑⡐⠔⡠⠑⠄⠅⡂⠡⠨⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠅⢐⠈⠄⠡⠨⢐⢀⠂⢅⠡⠂⢅⠢⠡⡑⢄⠕⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⡪⡊⡎⢜⢌⢢⠱⡨⢂⠕⡐⢌⠌⠔⡡⠡⡁⠢⠁⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠨⠠⠡⢁⢂⠂⠅⠢⠨⡨⢂⠪⠨⡂⢕⠨⡂⡢⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⢪⢪⢪⢸⢨⢢⢑⢆⠣⡊⡢⡑⢌⠢⡡⡑⡐⠅⠌⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠂⠈⠈⠊⠈⠐⠐⠁⠑⠈⠂⠑⠑⠈⠊⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣠⢺⡸⡸⡸⡸⡸⡨⡪⡊⡆⡣⡱⡨⢪⠨⡊⢔⠌⠂⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢠⢞⡕⡧⡳⡹⡸⡪⡪⡪⡪⡪⡊⡎⡢⡣⡑⠕⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
EOF

show_menu() {
    echo "Please select an option:"
    echo "1. Install Xandeum pNode Software"
    echo "2. Update Xandeum pNode Software"
    echo "3. Stop/Restart/Disable Service"
    echo "4. Upgrade This Installer Script (Disabled for Security)"
    echo "5. Harden SSH (Disable Password Login)"
    echo "6. Exit"
    read -p "Enter your choice (1-6):" choice
    case $choice in
    1) start_install ;;
    2) upgrade_install ;;
    3) actions ;;
    4) 
        echo "Self-update is disabled in this hardened version to prevent reverting security fixes."
        sleep 2
        show_menu
        ;;
    5) harden_ssh ;;
    6)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid option. Please try again."
        show_menu
        ;;
    esac
}

sudoCheck() {
    # Check for root/sudo privileges
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root or with sudo. Please try again with sudo."
        exit 1
    fi
}

# SECURITY FIX: Ensure dedicated user exists
ensure_service_user() {
    if ! id -u xandminer >/dev/null 2>&1; then
        echo "Creating system user 'xandminer'..."
        # Create system user with /opt/xandminer as home, no login shell
        useradd -r -s /usr/sbin/nologin -d "$INSTALL_BASE/xandminer" -m xandminer
    fi
}

select_branch() {
    local REPO_NAME=$1
    local REPO_URL=$2
    
    echo "" >&2
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
    echo "  Branch Selection for $REPO_NAME" >&2
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
    echo "" >&2
    echo "Fetching branches from $REPO_URL..." >&2
    
    # SECURITY FIX: Use mktemp for all temporary directories
    TEMP_DIR=$(mktemp -d)
    trap 'rm -rf "$TEMP_DIR"' RETURN
    
    cd "$TEMP_DIR"
    
    # Clone with minimal depth to get branch info
    git clone --bare "$REPO_URL" repo.git 2>/dev/null || {
        echo "Error: Failed to fetch repository information" >&2
        return 1
    }
    
    cd repo.git
    
    # Get 10 most recent branches with commit info
    echo "Most recent 10 branches:" >&2
    echo "" >&2
    
    # SECURITY FIX: Use secure temp file within the secure temp directory
    BRANCHES_FILE="$TEMP_DIR/branches.txt"
    
    # Format: branch-name | commit-date | commit-message
    git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)|%(committerdate:short)|%(contents:subject)' --count=10 > "$BRANCHES_FILE"
    
    # Display branches with numbers
    local counter=1
    declare -a BRANCH_ARRAY
    
    while IFS='|' read -r branch date message; do
        BRANCH_ARRAY[$counter]="$branch"
        printf "%2d. %-30s %s  %s\n" "$counter" "$branch" "$date" "$message" >&2
        ((counter++))
    done < "$BRANCHES_FILE"
    
    echo "" >&2
    
    # Clean up will be handled by trap
    
    # Prompt for selection
    while true; do
        read -p "Select branch number (1-10) or enter custom branch name: " BRANCH_CHOICE >&2
        
        # Check if input is a number
        if [[ "$BRANCH_CHOICE" =~ ^[0-9]+$ ]] && [ "$BRANCH_CHOICE" -ge 1 ] && [ "$BRANCH_CHOICE" -lt "$counter" ]; then
            SELECTED_BRANCH="${BRANCH_ARRAY[$BRANCH_CHOICE]}"
            echo "Selected: $SELECTED_BRANCH" >&2
            echo "$SELECTED_BRANCH"
            return 0
        elif [ -n "$BRANCH_CHOICE" ]; then
            # Treat as custom branch name
            # SECURITY FIX: Sanitize input
            SANITIZED_BRANCH=$(echo "$BRANCH_CHOICE" | sed 's/[^a-zA-Z0-9._/-]//g')
            if [ -z "$SANITIZED_BRANCH" ]; then
                 echo "Invalid branch name format." >&2
                 continue
            fi
            echo "Using custom branch: $SANITIZED_BRANCH" >&2
            echo "$SANITIZED_BRANCH" >&2
            return 0
        else
            echo "Invalid selection. Please try again." >&2
        fi
    done
}

select_pod_version() {
    echo "" >&2
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
    echo "  Trynet Pod Version Selection" >&2
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >&2
    echo "" >&2
    echo "Adding trynet repository..." >&2
    
    # Add trynet repository
    echo "deb [trusted=yes] https://raw.githubusercontent.com/Xandeum/trynet-packages/main/ stable main" | tee /etc/apt/sources.list.d/xandeum-pod-trynet.list >/dev/null
    apt-get update >/dev/null 2>&1
    
    echo "Fetching available trynet versions..." >&2
    echo "" >&2
    
    # SECURITY FIX: Use mktemp
    VERSION_FILE=$(mktemp)
    
    # Get trynet versions and format them
    apt-cache madison pod 2>/dev/null | grep trynet | head -10 | awk '{print $3}' > "$VERSION_FILE"
    
    if [ ! -s "$VERSION_FILE" ]; then
        echo "Error: Could not fetch trynet versions. Using latest stable." >&2
        rm -f "$VERSION_FILE"
        echo "stable"
        return 0
    fi
    
    echo "Available trynet pod versions (10 most recent):" >&2
    echo "" >&2
    
    # Display versions with numbers
    local counter=1
    declare -a VERSION_ARRAY
    
    while read -r version; do
        VERSION_ARRAY[$counter]="$version"
        local timestamp=$(echo "$version" | grep -oP '(?<=trynet\.)\d{14}' | sed 's/\(.\{4\}\)\(.\{2\}\)\(.\{2\}\)/\1-\2-\3/')
        local commit=$(echo "$version" | grep -oP '[a-f0-9]{7}(?=-1)' | head -1)
        
        printf "%2d. %-50s %s  %s\n" "$counter" "$version" "$timestamp" "$commit" >&2
        ((counter++))
    done < "$VERSION_FILE"
    
    echo "" >&2
    rm -f "$VERSION_FILE"
    
    # Prompt for selection
    while true; do
        read -p "Select version number (1-10), enter custom version, or press Enter for latest stable: " VERSION_CHOICE >&2
        
        if [ -z "$VERSION_CHOICE" ]; then
            echo "Using latest stable version" >&2
            echo "stable"
            return 0
        elif [[ "$VERSION_CHOICE" =~ ^[0-9]+$ ]] && [ "$VERSION_CHOICE" -ge 1 ] && [ "$VERSION_CHOICE" -lt "$counter" ]; then
            SELECTED_VERSION="${VERSION_ARRAY[$VERSION_CHOICE]}"
            echo "Selected: $SELECTED_VERSION" >&2
            echo "$SELECTED_VERSION"
            return 0
        elif [ -n "$VERSION_CHOICE" ]; then
            # SECURITY FIX: Strict sanitization of version string
            # Allow alphanum, tilde, dot, hyphen, plus
            SANITIZED_VERSION=$(echo "$VERSION_CHOICE" | sed 's/[^a-zA-Z0-9.~+-]//g')
            
            if [ -z "$SANITIZED_VERSION" ]; then
                echo "Invalid version string format." >&2
                continue
            fi
            
            echo "Using custom version: $SANITIZED_VERSION" >&2
            echo "$SANITIZED_VERSION"
            return 0
        else
            echo "Invalid selection. Please try again." >&2
        fi
    done
}

harden_ssh() {
    sudoCheck
    echo "Backing up SSH configuration files..."
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak-$(date +%Y%m%d%H%M%S)

    echo "Configuring SSH settings in /etc/ssh/sshd_config.d..."
    
    mkdir -p /etc/ssh/sshd_config.d
    SSHD_D_FILE="/etc/ssh/sshd_config.d/10-xandeum-harden.conf"
    
    # SECURITY FIX: Prefer drop-in config over sed-ing the main config file where possible
    cat >"$SSHD_D_FILE" <<EOL
PasswordAuthentication no
ChallengeResponseAuthentication no
EOL
    chmod 644 "$SSHD_D_FILE"

    # We still ensure the main config includes the .d directory or has these set, 
    # but we will use a safer approach for the main file if needed.
    # Ideally, we trust the drop-in if the distro supports it. 
    # If we must edit sshd_config, we do it minimally.
    if ! grep -q "^Include /etc/ssh/sshd_config.d/" /etc/ssh/sshd_config; then
        # Fallback for older systems: modify inplace safely
        sed -i 's/^#*PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config
        sed -i 's/^#*ChallengeResponseAuthentication .*/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
    fi
    
    echo "Setup completed successfully! Please restart sshd manually or reboot to apply."
}

upgrade_install() {
    sudoCheck
    stop_service
    start_install
    ensure_xandeum_pod_tmpfile
    echo "Upgrade completed successfully!"
    restart_service
    echo "Service restart completed."
}

start_install() {
    sudoCheck
    ensure_service_user
    
    # Change to installation directory base
    # SECURITY FIX: Use /opt
    mkdir -p "$INSTALL_BASE"
    cd "$INSTALL_BASE"
    
    echo "Updating system packages..."
    apt update && apt upgrade -y
    apt install -y build-essential python3 make gcc g++ liblzma-dev

    echo "Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
    apt-get install -y nodejs

    if [ "$DEV_MODE" = true ]; then
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "  DEV MODE: Repository Branch Selection"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        XANDMINER_BRANCH=$(select_branch "xandminer" "https://github.com/Xandeum/xandminer.git")
        XANDMINERD_BRANCH=$(select_branch "xandminerd" "https://github.com/Xandeum/xandminerd.git")
        POD_VERSION=$(select_pod_version)
    fi

    # Handle Repositories
    # We clone into /opt/xandminer and /opt/xandminerd
    
    if [ -d "xandminer" ] && [ -d "xandminerd" ]; then
        echo "Repositories already exist. Updating..."
        (
            cd xandminer
            git stash push -m "Auto-stash before pull" || true
            if [ "$DEV_MODE" = true ]; then
                git fetch origin
                git checkout "$XANDMINER_BRANCH"
                git pull origin "$XANDMINER_BRANCH"
            else
                git pull
            fi
        )
        (
            cd xandminerd
            git stash push -m "Auto-stash before pull" || true
            if [ "$DEV_MODE" = true ]; then
                git fetch origin
                git checkout "$XANDMINERD_BRANCH"
                git pull origin "$XANDMINERD_BRANCH"
            else
                git pull
            fi
            
            # Keypair handling
            if [ -f "keypairs/pnode-keypair.json" ]; then
                mkdir -p /local/keypairs
                if [ ! -f "/local/keypairs/pnode-keypair.json" ]; then
                    cp keypairs/pnode-keypair.json /local/keypairs/
                    # Ensure strict permissions on key
                    chmod 600 /local/keypairs/pnode-keypair.json
                    echo "Copied pnode-keypair.json to /local/keypairs/"
                fi
            fi
        )
    else
        echo "Cloning repositories..."
        git clone https://github.com/Xandeum/xandminer.git
        git clone https://github.com/Xandeum/xandminerd.git
        
        if [ "$DEV_MODE" = true ]; then
            ( cd xandminer && git checkout "$XANDMINER_BRANCH" )
            ( cd xandminerd && git checkout "$XANDMINERD_BRANCH" )
        fi
    fi

    # SECURITY FIX: Ensure the restricted user owns the application files
    echo "Setting file permissions..."
    chown -R xandminer:xandminer "$XANDMINER_DIR"
    chown -R xandminer:xandminer "$XANDMINERD_DIR"

    install_pod
    
    echo "Configuring Xandminer web service..."
    
    # SECURITY FIX: Generate service file securely inline with low-privilege User
    cat > /etc/systemd/system/xandminer.service <<EOF
[Unit]
Description=xandminer web Service
After=network.target

[Service]
ExecStart=/usr/bin/npm run start
WorkingDirectory=$XANDMINER_DIR
Restart=always
User=xandminer
Group=xandminer
Environment=NODE_ENV=production
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=xandminer

[Install]
WantedBy=multi-user.target
EOF

    echo "Building xandminer app..."
    # Build as the correct user to avoid permission issues later
    sudo -u xandminer bash -c "cd $XANDMINER_DIR && npm install && npm run build"

    systemctl daemon-reload
    systemctl enable xandminer.service --now
    echo "Xandminer web Service Running On Port : 3000"

    echo "Configuring Xandminerd service..."
    
    # SECURITY FIX: Generate service file securely inline
    cat > /etc/systemd/system/xandminerd.service <<EOF
[Unit]
Description=xandminerd Node.js Service
After=network.target

[Service]
ExecStart=/usr/bin/node $XANDMINERD_DIR/src/index.js
WorkingDirectory=$XANDMINERD_DIR
Restart=always
User=xandminer
Group=xandminer
Environment=NODE_ENV=production
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=xandminerd

[Install]
WantedBy=multi-user.target
EOF

    echo "Setting up Xandminerd..."
    sudo -u xandminer bash -c "cd $XANDMINERD_DIR && npm install"
    
    systemctl daemon-reload
    systemctl enable xandminerd.service --now
    echo "Xandminerd Service Running On Port : 4000"

    echo "To access your Xandminer, use address localhost:3000 in your web browser"
    echo "Setup completed successfully!"

    ensure_xandeum_pod_tmpfile
}

stop_service() {
    echo "Stopping Xandeum services..."
    systemctl stop xandminer.service
    systemctl stop xandminerd.service
    echo "All services stopped successfully."
}

disable_service() {
    echo "Disabling Xandeum service..."
    systemctl disable xandminerd.service --now
    systemctl disable xandminer.service --now
}

restart_service() {
    echo "Restarting Xandeum service..."
    ensure_xandeum_pod_tmpfile
    
    if [ ! -L /run/xandeum-pod ]; then
        systemd-tmpfiles --create
    fi

    systemctl daemon-reload
    systemctl restart pod.service
    systemctl restart xandminerd.service
    systemctl restart xandminer.service
}

install_pod() {
    sudo apt-get install -y apt-transport-https ca-certificates

    echo "deb [trusted=yes] https://xandeum.github.io/pod-apt-package/ stable main" | sudo tee /etc/apt/sources.list.d/xandeum-pod.list
    sudo apt-get update

    if [ "$DEV_MODE" = true ] && [ -n "$POD_VERSION" ] && [ "$POD_VERSION" != "stable" ]; then
        echo "Installing trynet pod version: $POD_VERSION"
        # SECURITY FIX: Quote the variable to prevent argument injection
        sudo apt-get install -y --allow-downgrades "pod=$POD_VERSION"
    else
        echo "Installing latest stable pod version"
        sudo apt-get install -y pod
    fi

    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Keypair Configuration"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Enter the path to your pNode keypair file."
    read -p "Keypair path [/local/keypairs/pnode-keypair.json]: " KEYPAIR_PATH
    
    if [ -z "$KEYPAIR_PATH" ]; then
        KEYPAIR_PATH="/local/keypairs/pnode-keypair.json"
    elif [ "$KEYPAIR_PATH" = "none" ] || [ "$KEYPAIR_PATH" = "NONE" ]; then
        KEYPAIR_PATH=""
    fi

    # SECURITY FIX: Sanitize Path
    if [ -n "$KEYPAIR_PATH" ]; then
        # Check for dangerous characters
        if [[ "$KEYPAIR_PATH" =~ [^a-zA-Z0-9/._-] ]]; then
             echo "WARNING: Keypair path contains special characters. Ignoring."
             KEYPAIR_PATH=""
        fi
    fi

    echo "Make pRPC API public? (y/N): " 
    read MAKE_PUBLIC

    EXEC_START_CMD="/usr/bin/pod"
    
    if [ -n "$KEYPAIR_PATH" ] && [ -f "$KEYPAIR_PATH" ]; then
        echo "Using keypair at: $KEYPAIR_PATH"
        EXEC_START_CMD="$EXEC_START_CMD --keypair $KEYPAIR_PATH"
    fi
    
    if [[ "$MAKE_PUBLIC" =~ ^[Yy]$ ]]; then
        echo "✓ Configuring pod with PUBLIC pRPC API (--rpc-ip 0.0.0.0)"
        EXEC_START_CMD="$EXEC_START_CMD --rpc-ip 0.0.0.0"
    else
        echo "✓ Configuring pod with PRIVATE pRPC API (--rpc-ip 127.0.0.1)"
        EXEC_START_CMD="$EXEC_START_CMD --rpc-ip 127.0.0.1"
    fi

    SERVICE_FILE="/etc/systemd/system/pod.service"

    # SECURITY FIX: Use proper quoting for systemd generation
    sudo tee "$SERVICE_FILE" >/dev/null <<EOF
[Unit]
Description= Xandeum Pod System service
After=network.target

[Service]
ExecStart=$EXEC_START_CMD
Restart=always
RestartSec=2
User=root
Environment=NODE_ENV=production
Environment=RUST_LOG=info
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=xandeum-pod

[Install]
WantedBy=multi-user.target
EOF

    sudo systemctl daemon-reload
    sudo systemctl enable pod.service
    sudo systemctl start pod.service
    
    if [[ "$MAKE_PUBLIC" =~ ^[Yy]$ ]]; then
        echo "⚠️  SECURITY REMINDER: Port 6000 is now public."
    fi
}

actions() {
    echo "1. Restart Service"
    echo "2. Stop Service"
    echo "3. Disable Service"
    echo "4. Previous Menu"

    read -p "Enter your choice (1-4): " choice
    case $choice in
    1) restart_service ;;
    2) stop_service ;;
    3) disable_service ;;
    4) show_menu ;;
    *) actions ;;
    esac
}

ensure_xandeum_pod_tmpfile() {
    TMPFILE="/etc/tmpfiles.d/xandeum-pod.conf"
    if [ ! -f "$TMPFILE" ]; then
        echo "L /run/xandeum-pod - - - - /xandeum-pages" > "$TMPFILE"
    fi
    systemd-tmpfiles --create
}

show_menu