#!/bin/bash
 
set -e

chown -R "unmanic":"unmanic" /config

FILE=""

for base in "/usr/local/lib" "/usr/lib"; do
  PY_DIR="$(ls "$base"/ 2>/dev/null | grep -E 'python[0-9]+\.[0-9]+' | sort -V | tail -n1)"
  if [ -n "${base}/${PY_DIR:-}" ] && [ -f "${base}/${PY_DIR}/dist-packages/unmanic/libs/session.py" ]; then
    FILE="${base}/${PY_DIR}/dist-packages/unmanic/libs/session.py"
    break
  fi
done

[ -n "${FILE:-}" ] || { echo "unmanic/libs/session.py introuvable sous /usr/local|/usr."; exit 1; }
echo "Cible: $FILE"

sed -i -E '
/^class[[:space:]]+Session\b[^\n]*:/,/^[^[:space:]]/{
  s/^([[:space:]]*)level[[:space:]]*=.*/\1level = 5/
  s/^([[:space:]]*)library_count[[:space:]]*=.*/\1library_count = 200/
  s/^([[:space:]]*)link_count[[:space:]]*=.*/\1link_count = 3/
}
' "$FILE"

cat >/tmp/add_return_after_docstring.sed <<'SED'
/^[[:space:]]*def[[:space:]]+register_unmanic[[:space:]]*\([[:space:]]*self[[:space:]]*,[[:space:]]*force[[:space:]]*=[[:space:]]*False[[:space:]]*\)[[:space:]]*:/,/^[^[:space:]]/{

  # Docstring sur une seule ligne: """..."""
  /^[[:space:]]*""".*"""[[:space:]]*$/a\
        return True

  # Docstring sur une seule ligne: '''...'''
  /^[[:space:]]*'''.*'''[[:space:]]*$/a\
        return True

  # Docstring multi-lignes: fermeture sur ligne seule """
  /^[[:space:]]*"""[[:space:]]*$/a\
        return True

  # Docstring multi-lignes: fermeture sur ligne seule '''
  /^[[:space:]]*'''[[:space:]]*$/a\
        return True
}
SED

sed -i -E -f /tmp/add_return_after_docstring.sed "$FILE"

rm -rf /tmp/unmanic/*
chown -R unmanic:unmanic /tmp/unmanic

exec gosu "unmanic" "/run.sh" "$@"
