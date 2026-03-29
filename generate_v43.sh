#!/bin/bash
# v43 — MASSIVE 300+ brushes: rooms, height variation, dense props, windows
OUT="v43_brushes.txt"
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

W="evil4_d_techwalls/d_tech_drkwall"
WP="evil4_d_techwalls/d_drkmtl_dpanel"
WS="evil4_d_techwalls/d_tech_drkwall_seam"
T="evil4_techtrims/dwtrim_panel"
TG="evil4_techtrims/dwtrim_grill"
F="evil4_techfloors/tfloor2"
M="evil4_metals/drkmtl_default"
AC="tech1soc_wall/grill_wall03a"
AF="tech1soc_floor/block01a"
PC="pk02/pk02_computer01a_C"

echo "// v43 MEGA — 300+ brushes: rooms, ceilings, props, windows" >> "$OUT"

# ============================================================
echo "" >> "$OUT"
echo "// === LOWERED CORRIDOR CEILINGS (z=192) — 10 sections ===" >> "$OUT"
for y in -1200 -960 -720 -480 -240 0 240 480 720 960; do
    box -512 $y 184 512 $((y+240)) 192 "$M" "$W"
done

echo "" >> "$OUT"
echo "// === LOWERED FLANK CEILINGS (z=152) — 8 sections ===" >> "$OUT"
for y in -480 -240 0 240; do
    box -1024 $y 144 -768 $((y+240)) 152 "$M" "$WS"
    box 768 $y 144 1024 $((y+240)) 152 "$M" "$WS"
done

echo "" >> "$OUT"
echo "// === CORRIDOR WALL PANELS (inset 8u) — 20 panels ===" >> "$OUT"
for y in -1150 -900 -650 -400 -150 150 400 650 900 1150; do
    box -520 $((y-40)) 16 -512 $((y+40)) 176 "$WP" "$WP"
    box 512 $((y-40)) 16 520 $((y+40)) 176 "$WP" "$WP"
done

echo "" >> "$OUT"
echo "// === CORRIDOR PILLAR TRIM RINGS — 26 trim caps ===" >> "$OUT"
for y in -1200 -1000 -800 -600 -400 -200 0 200 400 600 800 1000 1200; do
    box -500 $((y-20)) 0 -460 $((y+20)) 4 "$T" "$T"
    box 460 $((y-20)) 0 500 $((y+20)) 4 "$T" "$T"
done

echo "" >> "$OUT"
echo "// === APPROACH ZONE — enclosed tunnels with low ceiling ===" >> "$OUT"
# Red approach enclosed (y=-1400 to -1280, ceiling z=144)
box -512 -1408 136 512 -1272 144 "$M" "$M"
box -516 -1408 0 -512 -1272 144 "$W" "$W"
box 512 -1408 0 516 -1272 144 "$W" "$W"
# Neons inside
neon -508 -1400 80 -504 -1280 88 "urban_light/red_light_350"
neon 504 -1400 80 508 -1280 88 "urban_light/red_light_350"

# Blue approach enclosed
box -512 1272 136 512 1408 144 "$M" "$M"
box -516 1272 0 -512 1408 144 "$W" "$W"
box 512 1272 0 516 1408 144 "$W" "$W"
neon -508 1280 80 -504 1400 88 "urban_light/blue_light_350"
neon 504 1280 80 508 1400 88 "urban_light/blue_light_350"

echo "" >> "$OUT"
echo "// === FLANK ROOMS — 4 small rooms off walkways ===" >> "$OUT"
# West south room (-1024,-900) to (-768,-600) ceiling z=144
box -1024 -900 136 -768 -600 144 "$M" "$WS"
box -1024 -904 0 -768 -900 144 "$W" "$W"
box -1024 -600 0 -768 -596 144 "$W" "$W"
box -960 -860 0 -832 -828 40 "$AF" "$M"  # desk
box -952 -852 40 -840 -836 44 "$AF" "$M"  # desk top
box -1016 -880 80 -1008 -620 96 "$T" "$T"  # shelf
box -1016 -880 96 -776 -872 100 "$AF" "$T"  # shelf surface
neon -1020 -860 64 -1016 -640 72 "urban_light/green_light_200"

# West north room
box -1024 600 136 -768 900 144 "$M" "$WS"
box -1024 596 0 -768 600 144 "$W" "$W"
box -1024 900 0 -768 904 144 "$W" "$W"
box -960 828 0 -832 860 40 "$AF" "$M"
box -952 836 40 -840 852 44 "$AF" "$M"
box -1016 620 80 -1008 880 96 "$T" "$T"
box -1016 872 96 -776 880 100 "$AF" "$T"
neon -1020 640 64 -1016 860 72 "urban_light/green_light_200"

# East south room
box 768 -900 136 1024 -600 144 "$M" "$WS"
box 768 -904 0 1024 -900 144 "$W" "$W"
box 768 -600 0 1024 -596 144 "$W" "$W"
box 832 -860 0 960 -828 40 "$AF" "$M"
box 840 -852 40 952 -836 44 "$AF" "$M"
box 1008 -880 80 1016 -620 96 "$T" "$T"
box 776 -880 96 1016 -872 100 "$AF" "$T"
neon 1016 -860 64 1020 -640 72 "urban_light/red_light_200"

# East north room
box 768 600 136 1024 900 144 "$M" "$WS"
box 768 596 0 1024 600 144 "$W" "$W"
box 768 900 0 1024 904 144 "$W" "$W"
box 832 828 0 960 860 40 "$AF" "$M"
box 840 836 40 952 852 44 "$AF" "$M"
box 1008 620 80 1016 880 96 "$T" "$T"
box 776 872 96 1016 880 100 "$AF" "$T"
neon 1016 640 64 1020 860 72 "urban_light/red_light_200"

echo "" >> "$OUT"
echo "// === DENSE COVER — L-shaped barriers ===" >> "$OUT"
# L-barriers in corridor (tactical cover)
for y in -1050 -750 -450 450 750 1050; do
    # West L
    box -440 $((y-32)) 0 -400 $((y+32)) 80 "$W" "$W"
    box -440 $((y-32)) 0 -360 $((y-16)) 48 "$W" "$W"
    # East L (mirror)
    box 400 $((y-32)) 0 440 $((y+32)) 80 "$W" "$W"
    box 360 $((y+16)) 0 440 $((y+32)) 48 "$W" "$W"
done

echo "" >> "$OUT"
echo "// === STACKED CRATES in bases ===" >> "$OUT"
# Red base crate clusters (4 groups)
box -600 -1950 96 -536 -1886 152 "$AC" "$W"
box -584 -1940 152 -552 -1896 184 "$AC" "$W"
box -400 -1980 96 -336 -1916 144 "$AC" "$W"
box 336 -1980 96 400 -1916 144 "$AC" "$W"
box 536 -1950 96 600 -1886 152 "$AC" "$W"
box 552 -1940 152 584 -1896 176 "$AC" "$W"
# Blue base
box -600 1886 96 -536 1950 152 "$AC" "$W"
box -584 1896 152 -552 1940 184 "$AC" "$W"
box -400 1916 96 -336 1980 144 "$AC" "$W"
box 336 1916 96 400 1980 144 "$AC" "$W"
box 536 1886 96 600 1950 152 "$AC" "$W"
box 552 1896 152 584 1940 176 "$AC" "$W"

echo "" >> "$OUT"
echo "// === COMPUTER STATIONS in bases ===" >> "$OUT"
# Red base monitors (L-shaped desks with pk02 computer)
box -650 -2032 96 -550 -2000 112 "$PC" "$M"
box -650 -2032 112 -642 -2000 136 "$PC" "$M"
box -500 -2032 96 -400 -2000 112 "$PC" "$M"
box -500 -2032 112 -492 -2000 136 "$PC" "$M"
box 400 -2032 96 500 -2000 112 "$PC" "$M"
box 400 -2032 112 408 -2000 136 "$PC" "$M"
box 550 -2032 96 650 -2000 112 "$PC" "$M"
box 550 -2032 112 558 -2000 136 "$PC" "$M"
# Blue base
box -650 2000 96 -550 2032 112 "$PC" "$M"
box -650 2000 112 -642 2032 136 "$PC" "$M"
box -500 2000 96 -400 2032 112 "$PC" "$M"
box -500 2000 112 -492 2032 136 "$PC" "$M"
box 400 2000 96 500 2032 112 "$PC" "$M"
box 400 2000 112 408 2032 136 "$PC" "$M"
box 550 2000 96 650 2032 112 "$PC" "$M"
box 550 2000 112 558 2032 136 "$PC" "$M"

echo "" >> "$OUT"
echo "// === OUTER ROOM FURNITURE ===" >> "$OUT"
# Storage shelves (L-shaped along walls)
for side in -1 1; do
    xw=$((side * 1500))
    xw2=$((side * 1480))
    for y in -1100 -800 800 1100; do
        box $xw2 $((y-32)) 0 $xw $((y+32)) 96 "$M" "$T"
        box $xw2 $((y-32)) 96 $xw $((y+32)) 100 "$AF" "$T"
        box $xw2 $((y-32)) 48 $xw $((y+32)) 52 "$AF" "$T"
    done
done

echo "" >> "$OUT"
echo "// === UPPER LEVEL RAILINGS (building + catwalks) ===" >> "$OUT"
# Building upper floor railings at doorways
box -292 -132 128 -288 -128 168 "$M" "$M"
box -292 128 128 -288 132 168 "$M" "$M"
box -292 -128 160 -288 128 168 "$T" "$T"
box 288 -132 128 292 -128 168 "$M" "$M"
box 288 128 128 292 132 168 "$M" "$M"
box 288 -128 160 292 128 168 "$T" "$T"
# Building south doorway railing
box -100 -292 128 -96 -288 168 "$M" "$M"
box 96 -292 128 100 -288 168 "$M" "$M"
box -96 -292 160 96 -288 168 "$T" "$T"
# Building north doorway railing
box -100 288 128 -96 292 168 "$M" "$M"
box 96 288 128 100 292 168 "$M" "$M"
box -96 288 160 96 292 168 "$T" "$T"

echo "" >> "$OUT"
echo "// === FLOOR GRATES (dark strips for visual variety) ===" >> "$OUT"
for y in -1000 -600 -200 200 600 1000; do
    box -480 $((y-8)) 0 480 $((y+8)) 2 "$F" "$F"
done
# Flank floor grates
for y in -300 0 300; do
    box -1016 $((y-8)) 0 -776 $((y+8)) 2 "$F" "$F"
    box 776 $((y-8)) 0 1016 $((y+8)) 2 "$F" "$F"
done

echo "" >> "$OUT"
echo "// === PIPES — vertical pipes on walls ===" >> "$OUT"
# Vertical pipes on corridor walls
for y in -1100 -550 0 550 1100; do
    box -516 $((y-4)) 0 -512 $((y+4)) 192 "$M" "$M"
    box 512 $((y-4)) 0 516 $((y+4)) 192 "$M" "$M"
done
# Horizontal pipe connectors
for y in -1100 -550 0 550 1100; do
    box -524 $((y-8)) 96 -512 $((y+8)) 104 "$M" "$M"
    box 512 $((y-8)) 96 524 $((y+8)) 104 "$M" "$M"
done

echo "" >> "$OUT"
echo "// === CEILING LIGHT FIXTURES (recessed panels) ===" >> "$OUT"
for y in -1000 -500 0 500 1000; do
    box -128 $((y-32)) 184 128 $((y+32)) 188 "$WP" "$WP"
    neon -120 $((y-28)) 184 -116 $((y+28)) 188 "urban_light/blue_light_200"
    neon 116 $((y-28)) 184 120 $((y+28)) 188 "urban_light/blue_light_200"
done

echo "" >> "$OUT"
echo "// === MORE TRIM — door frames for flank rooms ===" >> "$OUT"
for y in -904 -896 -604 -596 596 604 896 904; do
    y2=$((y+8)); [ $y2 -le $y ] && y2=$((y-8))
    # West side
    box -1024 $y 0 -1016 $((y>0?y+4:y-4)) 144 "$T" "$T"
    box -776 $y 0 -768 $((y>0?y+4:y-4)) 144 "$T" "$T"
    # East side
    box 768 $y 0 776 $((y>0?y+4:y-4)) 144 "$T" "$T"
    box 1016 $y 0 1024 $((y>0?y+4:y-4)) 144 "$T" "$T"
done

COUNT=$(grep -c "^{" "$OUT")
echo "" >> "$OUT"
echo "// v43 total: $COUNT brushes" >> "$OUT"
echo "Generated $COUNT brushes"
