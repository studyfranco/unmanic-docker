#!/bin/bash
 
set -e

chown -R "unmanic":"unmanic" /config

FILE=""

for base in "/usr/local/lib" "/usr/lib"; do
  PY_DIR="$(ls -d "$base" 2>/dev/null | grep -E 'python[0-9]+\.[0-9]+' | sort -V | tail -n1)"
  if [ -n "${PY_DIR:-}" ] && [ -f "$PY_DIR/dist-packages/unmanic/libs/session.py" ]; then
    FILE="$PY_DIR/dist-packages/unmanic/libs/session.py"
    break
  fi
done

FILE="/usr/local/lib/python3.13/dist-packages/unmanic/libs/session.py"

[ -n "${FILE:-}" ] || { echo "unmanic/libs/session.py introuvable sous /usr/local|/usr."; exit 1; }
echo "Cible: $FILE"

sed -i -E '
/^class[[:space:]]+Session\b[^\n]*:/,/^[^[:space:]]/{
  s/^([[:space:]]*)level[[:space:]]*=.*/\1level = 5/
  s/^([[:space:]]*)library_count[[:space:]]*=.*/\1library_count = 200/
  s/^([[:space:]]*)link_count[[:space:]]*=.*/\1link_count = 3/
}
' "$FILE"

#sed -i -E '
#/^[[:space:]]*def[[:space:]]+register_unmanic[[:space:]]*\([[:space:]]*self[[:space:]]*,[[:space:]]*force[[:space:]]*=[[:space:]]*False[[:space:]]*\)[[:space:]]*:/,/^[^[:space:]]/{
#  /^[[:space:]]*("""|'"'"'""")[[:space:]]*$/{
#    a\        return True
#    q
#  }
#}
#' "$FILE"

exec gosu "unmanic" "/run.sh" "$@"