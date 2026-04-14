#!/bin/bash

# Build the project
cd "$(dirname "$0")/.."
go build -o whiptail ./cmd/whiptail

echo "=== Whiptail-Go Test Suite ==="
echo ""

# Test 1: Menu
echo "Test 1: Menu Widget"
./whiptail --menu "Select your favorite color" 12 40 3 \
    1 "Red" \
    2 "Green" \
    3 "Blue"
echo "Exit code: $?"
echo ""

# Test 2: Yes/No
echo "Test 2: Yes/No Widget"
./whiptail --yesno "Do you like Go programming?" 7 40
echo "Exit code: $?"
echo ""

# Test 3: Message Box
echo "Test 3: Message Box"
./whiptail --msgbox "This is a message box\n\nPress Enter to continue" 8 50
echo "Exit code: $?"
echo ""

# Test 4: Input Box
echo "Test 4: Input Box"
./whiptail --inputbox "Enter your name:" 8 40
echo "Exit code: $?"
echo ""

# Test 5: Password Box
echo "Test 5: Password Box"
./whiptail --passwordbox "Enter your secret:" 8 40
echo "Exit code: $?"
echo ""

# Test 6: Checklist with pre-selected items
echo "Test 6: Checklist (Lettuce and Tomatoes should be pre-selected)"
./whiptail --checklist "Select toppings:" 12 50 4 \
    1 "Lettuce" on \
    2 "Tomatoes" on \
    3 "Cheese" off \
    4 "Bacon" off
echo "Exit code: $?"
echo ""

# Test 7: Radiolist with pre-selected item (Medium should be pre-selected)
echo "Test 7: Radiolist (Medium should be pre-selected)"
./whiptail --radiolist "Choose your size:" 10 40 3 \
    1 "Small" off \
    2 "Medium" on \
    3 "Large" off
echo "Exit code: $?"
echo ""

# Test 8: Title option
echo "Test 8: Title Option"
./whiptail --title "Custom Title" --msgbox "This has a custom title" 8 50
echo "Exit code: $?"
echo ""

# Test 9: Cancel operation with ESC (should return exit code 1)
echo "Test 9: Cancel Operation (press ESC to cancel - should return exit code 1)"
./whiptail --yesno "Press ESC to cancel" 7 40
echo "Exit code: $?"
echo ""

# Test 10: Unimplemented --gauge (should error)
echo "Test 10: Unimplemented --gauge (should error with exit code 255)"
./whiptail --gauge "Progress" 6 50 0
echo "Exit code: $?"
echo ""

# Test 11: Multiple menu items
echo "Test 11: Menu with many items"
./whiptail --menu "Select a Linux distribution" 15 60 6 \
    1 "Ubuntu" \
    2 "Fedora" \
    3 "Debian" \
    4 "Arch Linux" \
    5 "OpenSUSE" \
    6 "CentOS"
echo "Exit code: $?"
echo ""

# Test 12: Checklist with all off
echo "Test 12: Checklist (all off by default)"
./whiptail --checklist "Optional features:" 12 50 3 \
    1 "Feature A" off \
    2 "Feature B" off \
    3 "Feature C" off
echo "Exit code: $?"
echo ""

# Test 13: Radiolist with all off (should default to first item)
echo "Test 13: Radiolist (all off by default - should select first item)"
./whiptail --radiolist "Choose an option:" 10 40 3 \
    1 "Option A" off \
    2 "Option B" off \
    3 "Option C" off
echo "Exit code: $?"
echo ""

echo "=== Test Suite Complete ==="
echo ""
echo "Exit code summary:"
echo "  0 = OK / Yes / Item selected"
echo "  1 = Cancel / No / ESC pressed / No selection"
echo "  255 = Error (invalid args, unimplemented feature, etc.)"
