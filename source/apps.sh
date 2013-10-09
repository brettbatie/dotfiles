# function myapt {
#     # List applications that are not installed when comparing to $dotfiles/apps.list
#     diff $dotfiles/apps.list (aptitude search '~i!~M' | sed -r 's/i\s+([^ ]+).*/\1/g')

#     read -p "Preparing to install the above applications (from $dotfiles/apps.list). Continue?" -n 1 -r
#     # if not yes, then skip it
#     if [[! $REPLY = ~ ^[Yy]$]]; then
#         aptitude install --prompt --visual-preview $(diff $dotfiles/apps.list (aptitude search '~i!~M' | sed -r 's/i\s+([^ ]+).*/\1/g'))
#     fi
# }

# function createmyapt {
#     read -p "Recreate the apps list?" -n 1 -r
#     # if not yes, then skip it
#     if [[! $REPLY = ~ ^[Yy]$]]; then
#         aptitude search '~i!~M' > $dotfiles/apps.list
#     fi
# }