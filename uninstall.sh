#!/bin/bash

# Script Uninstall Aplikasi tar.xz untuk Arch Linux
# Untuk menghapus aplikasi yang diinstall via install-tarxz-app.sh

set -e

# Warna untuk output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Fungsi untuk mencari aplikasi yang terinstall
list_installed_apps() {
    print_info "Aplikasi tar.xz yang terinstall di /opt:"
    local apps=($(find /opt -maxdepth 1 -type d -name "*" | grep -v "^/opt$" | sort))
    
    if [[ ${#apps[@]} -eq 0 ]]; then
        print_warning "Tidak ada aplikasi ditemukan di /opt"
        return 1
    fi
    
    for i in "${!apps[@]}"; do
        local app_name=$(basename "${apps[$i]}")
        local desktop_file="/usr/share/applications/${app_name,,}.desktop"
        local symlink="/usr/local/bin/${app_name,,}"
        
        printf "%2d. %-20s" $((i+1)) "$app_name"
        
        # Cek komponen yang ada
        [[ -f "$desktop_file" ]] && printf " [Desktop]"
        [[ -L "$symlink" ]] && printf " [Symlink]"
        printf "\n"
    done
    
    echo "${apps[@]}"
}

# Fungsi untuk uninstall aplikasi
uninstall_app() {
    local app_path="$1"
    local app_name=$(basename "$app_path")
    
    print_info "Menghapus aplikasi: $app_name"
    print_info "Lokasi: $app_path"
    
    # Komponen yang akan dihapus
    local desktop_file="/usr/share/applications/${app_name,,}.desktop"
    local symlink="/usr/local/bin/${app_name,,}"
    
    echo
    print_info "Komponen yang akan dihapus:"
    echo "  - Directory aplikasi: $app_path"
    
    if [[ -f "$desktop_file" ]]; then
        echo "  - Desktop entry: $desktop_file"
    fi
    
    if [[ -L "$symlink" ]]; then
        echo "  - Symbolic link: $symlink"
    fi
    
    echo
    echo -n "Lanjutkan penghapusan? [y/N]: "
    read -r confirm
    
    if [[ ! "$confirm" =~ ^[Yy] ]]; then
        print_info "Penghapusan dibatalkan"
        return 0
    fi
    
    # Hapus directory aplikasi
    if [[ -d "$app_path" ]]; then
        print_info "Menghapus directory aplikasi..."
        if sudo rm -rf "$app_path"; then
            print_success "Directory aplikasi berhasil dihapus"
        else
            print_error "Gagal menghapus directory aplikasi"
            return 1
        fi
    fi
    
    # Hapus desktop entry
    if [[ -f "$desktop_file" ]]; then
        print_info "Menghapus desktop entry..."
        if sudo rm -f "$desktop_file"; then
            print_success "Desktop entry berhasil dihapus"
        else
            print_warning "Gagal menghapus desktop entry"
        fi
    fi
    
    # Hapus symbolic link
    if [[ -L "$symlink" ]]; then
        print_info "Menghapus symbolic link..."
        if sudo rm -f "$symlink"; then
            print_success "Symbolic link berhasil dihapus"
        else
            print_warning "Gagal menghapus symbolic link"
        fi
    fi
    
    print_success "=== UNINSTALL SELESAI ==="
    print_info "Aplikasi '$app_name' berhasil dihapus dari sistem"
}

# Main script
main() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════╗"
    echo "║      Uninstall Aplikasi tar.xz           ║"
    echo "║           untuk Arch Linux              ║"
    echo "╚══════════════════════════════════════════╝"
    echo -e "${NC}"
    
    # Cek root
    if [[ $EUID -eq 0 ]]; then
        print_error "Jangan jalankan script ini sebagai root!"
        exit 1
    fi
    
    # List aplikasi yang terinstall
    local apps_output=$(list_installed_apps)
    
    if [[ $? -ne 0 ]]; then
        exit 1
    fi
    
    # Parse output untuk mendapatkan array aplikasi
    local apps=($apps_output)
    
    echo
    echo -n "Pilih aplikasi yang akan dihapus (1-${#apps[@]}): "
    read -r choice
    
    # Validasi input
    if [[ ! "$choice" =~ ^[0-9]+$ ]] || [[ $choice -lt 1 ]] || [[ $choice -gt ${#apps[@]} ]]; then
        print_error "Pilihan tidak valid!"
        exit 1
    fi
    
    # Uninstall aplikasi yang dipilih
    local selected_app="${apps[$((choice-1))]}"
    uninstall_app "$selected_app"
}

main "$@"
