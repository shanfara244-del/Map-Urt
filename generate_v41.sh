#!/bin/bash
# v41 — Additional geometry with varied textures from EvilLair + PK02
OUT="v41_brushes.txt"
> "$OUT"

box() {
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 top=$7 side=${8:-$7}
    cat >> "$OUT" << EOF
{
( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) $top 0 0 0 0.5 0.5 0 0 0
( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) $side 0 0 0 0.5 0.5 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) $side 0 0 0 0.5 0.5 0 0 0
( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) $side 0 0 0 0.5 0.5 0 0 0
( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) $side 0 0 0 0.5 0.5 0 0 0
}
EOF
}

neon() {
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 tex=$7
    cat >> "$OUT" << EOF
{
( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0
( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) $tex 0 0 0 0.5 0.5 0 0 0
( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0
( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0
}
EOF
}

# EvilLair textures
EW="evil4_d_techwalls/d_tech_drkwall"
EW2="evil4_d_techwalls/d_drkmtl_dpanel"
EW3="evil4_d_techwalls/d_tech_drkwall_seam"
ET="evil4_techtrims/evil4_mtl_strp1"
EF="evil4_techfloors/e4tflr_grt_01"
EM="evil4_metals/evil4_mtl2"

# PK02 textures
PW="pk02/pk02_wall01a_C"
PF="pk02/pk02_floor01_C"
PC="pk02/pk02_ceiling02_C"
PD="pk02/pk02_door01_C"
PP="pk02/pk02_computer01a_C"

# Tech1soc
T1="tech1soc_wall/grill_wall03a"
TF="tech1soc_floor/block01a"
TT="tech1soc_trim/032-01a"

echo "// v41 — Mixed-texture geometry with EvilLair + PK02" >> "$OUT"

echo "" >> "$OUT"
echo "// === CORRIDOR SIDE ALCOVES with evillair walls ===" >> "$OUT"
for y in -1100 -700 -300 300 700 1100; do
    # Deep alcove west with evillair back wall
    box -560 $((y-64)) 0 -528 $((y+64)) 160 "$EW" "$EW"
    box -528 $((y-72)) 0 -512 $((y-64)) 160 "$ET" "$ET"
    box -528 $((y+64)) 0 -512 $((y+72)) 160 "$ET" "$ET"
    neon -556 $((y-56)) 64 -552 $((y+56)) 72 "urban_light/blue_light_200"
    # Deep alcove east with pk02 back wall
    box 528 $((y-64)) 0 560 $((y+64)) 160 "$PW" "$PW"
    box 512 $((y-72)) 0 528 $((y-64)) 160 "$TT" "$TT"
    box 512 $((y+64)) 0 528 $((y+72)) 160 "$TT" "$TT"
    neon 552 $((y-56)) 64 556 $((y+56)) 72 "urban_light/red_light_200"
done

echo "" >> "$OUT"
echo "// === FLANK CORRIDOR enclosed sections with varied textures ===" >> "$OUT"
# West flank enclosed sections (lower ceiling z=160)
for y in -400 -200 0 200 400; do
    # Ceiling section
    box -1024 $((y-100)) 152 -768 $((y+100)) 160 "$EM" "$EM"
    # Side neon
    neon -1020 $((y-80)) 96 -1016 $((y+80)) 104 "urban_light/green_light_200"
done
# East flank
for y in -400 -200 0 200 400; do
    box 768 $((y-100)) 152 1024 $((y+100)) 160 "$EM" "$EM"
    neon 1016 $((y-80)) 96 1020 $((y+80)) 104 "urban_light/red_light_200"
done

echo "" >> "$OUT"
echo "// === OUTER ROOMS ceiling sections ===" >> "$OUT"
for y in -1100 -800 800 1100; do
    box -1536 $((y-150)) 168 -1024 $((y+150)) 176 "$EM" "$EM"
    box 1024 $((y-150)) 168 1536 $((y+150)) 176 "$EM" "$EM"
done

echo "" >> "$OUT"
echo "// === COMPUTER CONSOLES (pk02 textures) ===" >> "$OUT"
# Red base consoles
box -600 -2016 96 -400 -1984 112 "$PP" "$PP"
box -600 -2016 112 -592 -1984 128 "$PP" "$PP"
box 400 -2016 96 600 -1984 112 "$PP" "$PP"
box 400 -2016 112 408 -1984 128 "$PP" "$PP"
# Blue base consoles
box -600 1984 96 -400 2016 112 "$PP" "$PP"
box -600 1984 112 -592 2016 128 "$PP" "$PP"
box 400 1984 96 600 2016 112 "$PP" "$PP"
box 400 1984 112 408 2016 128 "$PP" "$PP"

echo "" >> "$OUT"
echo "// === PIPE RUNS along ceiling ===" >> "$OUT"
# Corridor pipes (thin horizontal bars at ceiling)
box -480 -1280 200 -472 1280 208 "$EM" "$EM"
box 472 -1280 200 480 1280 208 "$EM" "$EM"
# Flank pipes
box -960 -512 200 -952 512 208 "$EM" "$EM"
box 952 -512 200 960 512 208 "$EM" "$EM"

echo "" >> "$OUT"
echo "// === DOORFRAMES at room entrances (evillair trim) ===" >> "$OUT"
# Command room doorframes (4 rooms x 2 doors x 3 brushes = 24)
for y in -1800 -1600 1600 1800; do
    for x in -1024 768; do
        x2=$((x+256))
        xmid=$((x+128))
        # Door left jamb
        box $((xmid-80)) $((y-4)) 0 $((xmid-64)) $((y+4)) 144 "$ET" "$ET"
        # Door right jamb
        box $((xmid+64)) $((y-4)) 0 $((xmid+80)) $((y+4)) 144 "$ET" "$ET"
        # Door lintel
        box $((xmid-64)) $((y-4)) 136 $((xmid+64)) $((y+4)) 144 "$ET" "$ET"
    done
done

echo "" >> "$OUT"
echo "// === SCATTERED PROPS (evillair metal boxes) ===" >> "$OUT"
# Metal boxes scattered around map
for y in -1000 -500 -100 100 500 1000; do
    box $((400+RANDOM%100)) $((y-20)) 0 $((464+RANDOM%100)) $((y+20)) $((32+RANDOM%32)) "$EW2" "$EW2"
done
# Fixed position props
box -450 -150 0 -400 -100 64 "$EW2" "$EW3"
box -450 100 0 -400 150 48 "$EW2" "$EW3"
box 400 -150 0 450 -100 64 "$EW2" "$EW3"
box 400 100 0 450 150 48 "$EW2" "$EW3"

echo "" >> "$OUT"
echo "// === FLOOR VARIATION (different floor per zone) ===" >> "$OUT"
# Approach zone floors (raised 4u strips with different texture)
box -512 -1400 0 512 -1380 4 "$EF" "$EF"
box -512 -1300 0 512 -1280 4 "$EF" "$EF"
box -512 1280 0 512 1300 4 "$EF" "$EF"
box -512 1380 0 512 1400 4 "$EF" "$EF"
# Base floor trim
box -768 -2040 96 768 -2032 100 "$ET" "$ET"
box -768 2032 96 768 2040 100 "$ET" "$ET"

COUNT=$(grep -c "^{" "$OUT")
echo "" >> "$OUT"
echo "// v41 total: $COUNT brushes" >> "$OUT"
echo "Generated $COUNT brushes"
