# Random hexes slowed and colored by grep to appear busy
hexdump -C < /dev/urandom | grep "01 02" --color=auto
