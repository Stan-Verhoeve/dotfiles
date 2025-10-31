# Directory to save screenshots
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

# File name
FILE="$DIR/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"

# Capture selected area
grim -g "$(slurp)" "$FILE"
