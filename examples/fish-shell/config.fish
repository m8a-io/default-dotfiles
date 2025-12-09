if status is-interactive
    # Commands to run in interactive sessions can go here
    echo "Welcome to Fish Shell on m8a!"
end

# Remove default greeting
set -U fish_greeting ""

# Aliases
alias ll "ls -lah"
alias g "git"

# Function to setup starship if installed
if type -q starship
    starship init fish | source
end

# m8a Mock Wrapper for Fish
function m8a
    if test "$argv[1]" = "source"
        echo "⚠️  Mocking m8a binary (Fish Wrapper)..."
        
        set -l INSTALL_SCRIPT ""
        if test -f "m8a.yaml"
            set -l VAL (grep "install:" m8a.yaml | cut -d'"' -f2)
            if test -n "$VAL"
                set INSTALL_SCRIPT "$VAL"
            end
        else
            echo "❌ m8a.yaml not found."
            return 1
        end

        echo ">> Executing: $INSTALL_SCRIPT"
        if test -f "$INSTALL_SCRIPT"
            sh "$INSTALL_SCRIPT"
            set -l EXIT_CODE $status
            if test $EXIT_CODE -eq 0
                echo "✨ Configuration updated. Reloading shell..."
                # Reload the actual system shell
                set -l NEW_SHELL (getent passwd $USER | cut -d: -f7)
                if test -z "$NEW_SHELL"
                     set NEW_SHELL $SHELL
                end
                
                exec $NEW_SHELL
            else
                echo "❌ Dotfiles update failed."
                return 1
            end
        else
            echo "❌ Script not found: $INSTALL_SCRIPT"
            return 1
        end
    else
        command m8a $argv
    end
end
