# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "$method"="lwp-request -m '$method'"
done

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

if [ -n "$DISPLAY" ]; then
    xset b off
fi
