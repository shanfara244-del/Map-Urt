#!/bin/bash
# v52 — Rebuild Server Room + Red Base + Central Plaza to Casa quality
OUT="v52_zones.txt"
> "$OUT"

W="evil4_d_techwalls/d_tech_drkwall"
WP="evil4_d_techwalls/d_drkmtl_dpanel"
WS="evil4_d_techwalls/d_tech_drkwall_seam"
T="evil4_techtrims/dwtrim_panel"
F="evil4_techfloors/tfloor2"
M="evil4_metals/drkmtl_default"
AC="tech1soc_wall/grill_wall03a"
AF="tech1soc_floor/block01a"
PC="pk02/pk02_computer01a_C"
C="common/caulk"
H="metal/metal_darkgrey"

wall_ns() {
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 tw=$7 te=$8
    cat >> "$OUT" << EOF
{
( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) $C 0 0 0 0.25 0.25 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) $C 0 0 0 0.25 0.25 0 0 0
( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) $tw 0 0 0 0.5 0.5 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) $te 0 0 0 0.5 0.5 0 0 0
( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) $C 0 0 0 0.25 0.25 0 0 0
( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) $C 0 0 0 0.25 0.25 0 0 0
}
EOF
}

wall_ew() {
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 ts=$7 tn=$8
    cat >> "$OUT" << EOF
{
( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) $C 0 0 0 0.25 0.25 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) $C 0 0 0 0.25 0.25 0 0 0
( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) $C 0 0 0 0.25 0.25 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) $C 0 0 0 0.25 0.25 0 0 0
( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) $ts 0 0 0 0.5 0.5 0 0 0
( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) $tn 0 0 0 0.5 0.5 0 0 0
}
EOF
}

slab() {
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 top=$7
    cat >> "$OUT" << EOF
{
( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) $C 0 0 0 0.25 0.25 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) $top 0 0 0 0.5 0.5 0 0 0
( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) $C 0 0 0 0.25 0.25 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) $C 0 0 0 0.25 0.25 0 0 0
( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) $C 0 0 0 0.25 0.25 0 0 0
( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) $C 0 0 0 0.25 0.25 0 0 0
}
EOF
}

neon() {
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 tex=$7
    cat >> "$OUT" << EOF
{
( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) $H 0 0 0 0.5 0.5 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) $H 0 0 0 0.5 0.5 0 0 0
( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) $H 0 0 0 0.5 0.5 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) $tex 0 0 0 0.5 0.5 0 0 0
( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) $H 0 0 0 0.5 0.5 0 0 0
( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) $H 0 0 0 0.5 0.5 0 0 0
}
EOF
}

echo "// v52 — SERVER ROOM + RED BASE + PLAZA rebuilt Casa-quality" >> "$OUT"

# ================================================================
echo "" >> "$OUT"
echo "// === SERVER ROOM (1200,-400) to (1800,400) — Casa rebuild ===" >> "$OUT"

# Floor + ceiling
slab 1200 -400 -8 1800 400 0 "$F"
slab 1200 -400 192 1800 400 200 "$C"

# West wall (with doorway y=-80..80)
wall_ns 1200 -400 16 1232 -80 176 "$W" "$C"
wall_ns 1200 80 16 1232 400 176 "$W" "$C"
wall_ns 1200 -400 0 1232 -80 16 "$T" "$C"
wall_ns 1200 80 0 1232 400 16 "$T" "$C"
wall_ns 1200 -400 176 1232 -80 192 "$T" "$C"
wall_ns 1200 80 176 1232 400 192 "$T" "$C"
wall_ns 1200 -80 160 1232 80 192 "$W" "$C"

# East wall (solid)
wall_ns 1768 -400 16 1800 400 176 "$C" "$W"
wall_ns 1768 -400 0 1800 400 16 "$C" "$T"
wall_ns 1768 -400 176 1800 400 192 "$C" "$T"

# South wall (doorway x=1400..1600)
wall_ew 1232 -400 16 1400 -368 176 "$C" "$W"
wall_ew 1600 -400 16 1768 -368 176 "$C" "$W"
wall_ew 1232 -400 0 1400 -368 16 "$C" "$T"
wall_ew 1600 -400 0 1768 -368 16 "$C" "$T"
wall_ew 1232 -400 176 1768 -368 192 "$C" "$T"
wall_ew 1400 -400 160 1600 -368 176 "$C" "$W"

# North wall (doorway x=1400..1600)
wall_ew 1232 368 16 1400 400 176 "$W" "$C"
wall_ew 1600 368 16 1768 400 176 "$W" "$C"
wall_ew 1232 368 0 1400 400 16 "$T" "$C"
wall_ew 1600 368 0 1768 400 16 "$T" "$C"
wall_ew 1232 368 176 1768 400 192 "$T" "$C"
wall_ew 1400 368 160 1600 400 176 "$W" "$C"

# Server racks (6 tall panels)
for y in -300 -180 -60 60 180 300; do
    wall_ns 1300 $((y-12)) 0 1320 $((y+12)) 160 "$WP" "$M"
    slab 1300 $((y-12)) 64 1320 $((y+12)) 68 "$M"
    slab 1300 $((y-12)) 128 1320 $((y+12)) 132 "$M"
done

# Upper walkway (south side, z=128)
slab 1232 -368 120 1768 -200 128 "$AF"
wall_ew 1232 -204 128 1768 -200 164 "$T" "$M"
slab 1232 -204 160 1768 -200 164 "$M"

# Stairs to walkway
slab 1700 -200 0 1768 -130 32 "$AF"
slab 1732 -200 32 1768 -160 64 "$AF"
slab 1752 -200 64 1768 -180 96 "$AF"
slab 1760 -200 96 1768 -190 128 "$AF"

# Neon
neon 1236 -380 160 1240 380 168 "urban_light/red_light_350"
neon 1764 -380 160 1768 380 168 "urban_light/red_light_350"
neon 1240 -204 120 1760 -200 128 "urban_light/red_light_200"

# Ceiling beams
slab 1200 -8 184 1800 8 192 "$M"
slab 1492 -400 184 1508 400 192 "$M"

# Ceiling panels
slab 1300 -350 180 1600 -100 184 "$WP"
slab 1300 100 180 1600 350 184 "$WP"

# Floor trim perimeter
slab 1232 -368 0 1768 -360 2 "$T"
slab 1232 360 0 1768 368 2 "$T"
slab 1232 -360 0 1240 360 2 "$T"
slab 1760 -360 0 1768 360 2 "$T"

# ================================================================
echo "" >> "$OUT"
echo "// === CENTRAL PLAZA enhanced (z=0/64/128) ===" >> "$OUT"

# Main platform trim ring
slab -264 -264 0 264 264 4 "$T"
slab -136 -136 60 136 136 64 "$T"
slab -136 -136 124 136 136 128 "$T"

# Pillar trim rings
for x in -600 600; do
    for y in -600 600; do
        slab $((x-24)) $((y-24)) 0 $((x+24)) $((y+24)) 4 "$T"
        slab $((x-24)) $((y-24)) 156 $((x+24)) $((y+24)) 160 "$T"
    done
done

# Additional cover walls (L-shaped for tactics)
wall_ns -700 -100 0 -664 100 80 "$W" "$W"
wall_ew -700 -100 0 -600 -64 48 "$W" "$W"
wall_ns 664 -100 0 700 100 80 "$W" "$W"
wall_ew 600 64 0 700 100 48 "$W" "$W"

# More cover at different heights
slab -300 -700 0 -200 -600 64 "$W"
slab 200 600 0 300 700 64 "$W"
slab -700 -500 0 -600 -400 48 "$W"
slab 600 400 0 700 500 48 "$W"

# Plaza floor grate accent
slab -400 -4 0 400 4 2 "$F"
slab -4 -400 0 4 400 2 "$F"

# Underground entrance frames (proper trim)
wall_ns -844 -100 -72 -840 100 4 "$T" "$T"
wall_ns 840 -100 -72 844 100 4 "$T" "$T"
slab -844 -100 -4 -840 100 0 "$T"
slab 840 -100 -4 844 100 0 "$T"

# ================================================================
echo "" >> "$OUT"
echo "// === RED BASE enhanced ===" >> "$OUT"

# Flag room walls with proper trim (32u thick)
# West wall
wall_ns -208 -1900 16 -176 -1700 176 "$C" "$W"
wall_ns -208 -1900 0 -176 -1700 16 "$C" "$T"
wall_ns -208 -1900 176 -176 -1700 192 "$C" "$T"
# East wall
wall_ns 176 -1900 16 208 -1700 176 "$W" "$C"
wall_ns 176 -1900 0 208 -1700 16 "$T" "$C"
wall_ns 176 -1900 176 208 -1700 192 "$T" "$C"
# South wall (solid back)
wall_ew -176 -1908 16 176 -1900 176 "$C" "$W"
wall_ew -176 -1908 0 176 -1900 16 "$C" "$T"
wall_ew -176 -1908 176 176 -1900 192 "$C" "$T"
# North wall (doorway -80..80)
wall_ew -176 -1700 16 -80 -1668 176 "$W" "$C"
wall_ew 80 -1700 16 176 -1668 176 "$W" "$C"
wall_ew -176 -1700 0 -80 -1668 16 "$T" "$C"
wall_ew 80 -1700 0 176 -1668 16 "$T" "$C"
wall_ew -176 -1700 176 176 -1668 192 "$T" "$C"
wall_ew -80 -1700 160 80 -1668 176 "$W" "$C"

# Flag pedestal
slab -64 -1840 0 64 -1760 24 "$AF"
slab -48 -1832 24 48 -1768 28 "$T"

# Console stations (back wall)
slab -160 -1896 0 -80 -1870 32 "$PC"
slab -160 -1896 32 -152 -1870 56 "$PC"
slab 80 -1896 0 160 -1870 32 "$PC"
slab 80 -1896 32 88 -1870 56 "$PC"

# Supply crates
slab -160 -1760 0 -112 -1712 48 "$AC"
slab -148 -1748 48 -124 -1724 72 "$AC"
slab 112 -1760 0 160 -1712 48 "$AC"

# Neon
neon -172 -1880 128 -168 -1720 136 "urban_light/red_light_500"
neon 168 -1880 128 172 -1720 136 "urban_light/red_light_500"
neon -60 -1836 24 60 -1832 28 "urban_light/red_light_200"

# Ceiling beams
slab -176 -1808 184 176 -1792 192 "$M"
slab -8 -1900 184 8 -1700 192 "$M"

# Floor trim
slab -176 -1892 0 176 -1888 2 "$T"
slab -176 -1708 0 176 -1704 2 "$T"
slab -172 -1888 0 -168 -1708 2 "$T"
slab 168 -1888 0 172 -1708 2 "$T"

COUNT=$(grep -c "^{" "$OUT")
echo "" >> "$OUT"
echo "// v52 total: $COUNT brushes" >> "$OUT"
echo "Generated $COUNT brushes"
