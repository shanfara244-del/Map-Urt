#!/bin/bash
# ================================================================
# v50 — COMPLETE MAP REDESIGN: Neon Duct
# 9 zones, 5 height levels, underground tunnel, competitive CTF
# Target: 600+ brushes
# ================================================================
OUT="C:\Users\Shanfara\Desktop\urt_map_project\maps\ut4_neonduct.map"

# Textures
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
H="metal/metal_darkgrey"
D="sweetnutz/sn_door7"

box() {
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 top=$7 side=${8:-$7}
    cat >> "$OUT" << EOF
{
( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) $H 0 0 0 0.5 0.5 0 0 0
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
( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) $H 0 0 0 0.5 0.5 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) $H 0 0 0 0.5 0.5 0 0 0
( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) $H 0 0 0 0.5 0.5 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) $tex 0 0 0 0.5 0.5 0 0 0
( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) $H 0 0 0 0.5 0.5 0 0 0
( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) $H 0 0 0 0.5 0.5 0 0 0
}
EOF
}

# room: floor + ceiling + 4 walls with doorway gaps
# room x1 y1 x2 y2 zf zc t wtex ftex
room() {
    local x1=$1 y1=$2 x2=$3 y2=$4 zf=$5 zc=$6 t=$7 wt=$8 ft=$9
    local xi=$((x1+t)) yi=$((y1+t)) xj=$((x2-t)) yj=$((y2-t))
    local xm=$(( (x1+x2)/2 ))
    local ym=$(( (y1+y2)/2 ))
    local dw=96  # doorway half-width
    # Floor
    box $x1 $y1 $((zf-8)) $x2 $y2 $zf "$ft" "$H"
    # Ceiling
    box $x1 $y1 $zc $x2 $y2 $((zc+8)) "$H" "$H"
    # West wall (full)
    box $x1 $y1 $zf $xi $y2 $zc "$wt" "$wt"
    # East wall (full)
    box $xj $y1 $zf $x2 $y2 $zc "$wt" "$wt"
    # South wall (gap in center for doorway)
    box $xi $y1 $zf $((xm-dw)) $yi $zc "$wt" "$wt"
    box $((xm+dw)) $y1 $zf $xj $yi $zc "$wt" "$wt"
    # North wall (gap in center)
    box $xi $yj $zf $((xm-dw)) $y2 $zc "$wt" "$wt"
    box $((xm+dw)) $yj $zf $xj $y2 $zc "$wt" "$wt"
}

# ================================================================
# START MAP FILE
# ================================================================
cat > "$OUT" << 'HEADER'
// ut4_neonduct v50 — Complete Redesign
// Underground Industrial Complex — Competitive CTF
// 9 zones, 5 height levels, underground tunnel
{
"classname" "worldspawn"
"message" "Neon Duct"
"ambient" "18"
"_color" "0.3 0.5 0.7"
"mingridlight" "10"
"gridsize" "64 64 128"

HEADER

echo "// ============================================================" >> "$OUT"
echo "// OUTER SHELL — 4096x4096, z=-80 to z=400" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# Floor (extends below for underground tunnel)
box -2064 -2064 -80 2064 2064 0 "$F" "$H"
# Ceiling
box -2064 -2064 384 2064 2064 400 "$H" "$H"
# West wall
box -2064 -2064 0 -2048 2064 384 "$H" "$W"
# East wall
box 2048 -2064 0 2064 2064 384 "$W" "$H"
# South wall
box -2048 -2064 0 2048 -2048 384 "$H" "$W"
# North wall
box -2048 2048 0 2048 2064 384 "$W" "$H"

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// ZONE 1: RED BASE (y=-2048 to -1600)" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# Flag room (-192,-1900) to (192,-1700), z=0-192
room -192 -1900 192 -1700 0 192 16 "$W" "$AF"
# Elevated platform behind flag
box -128 -2032 0 128 -1900 48 "$AF" "$T"
# Side alcoves
box -448 -2032 0 -256 -1800 128 "$W" "$W"
box -440 -2024 0 -264 -1808 8 "$AF" "$H"
box -440 -2024 120 -264 -1808 128 "$H" "$H"
box 256 -2032 0 448 -1800 128 "$W" "$W"
box 264 -2024 0 440 -1808 8 "$AF" "$H"
box 264 -2024 120 440 -1808 128 "$H" "$H"
# Neon
neon -188 -1880 96 -184 -1720 104 "urban_light/red_light_500"
neon 184 -1880 96 188 -1720 104 "urban_light/red_light_500"
# Base ceiling
box -512 -2048 184 512 -1600 192 "$H" "$WS"
# Corridor out of base (north)
box -128 -1700 0 128 -1600 8 "$F" "$H"
box -144 -1700 0 -128 -1600 192 "$W" "$W"
box 128 -1700 0 144 -1600 192 "$W" "$W"
box -128 -1700 176 128 -1600 184 "$H" "$H"
# Base trim
box -192 -1900 0 192 -1892 4 "$T" "$T"
box -192 -1708 0 192 -1700 4 "$T" "$T"

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// ZONE 2: RED SIDE ROOMS (y=-1600 to -1200)" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# Control Room WEST (-1600,-1500) to (-1100,-1300)
room -1600 -1500 -1100 -1300 0 160 16 "$WP" "$F"
# Desk
box -1500 -1460 0 -1350 -1420 36 "$AF" "$M"
box -1490 -1450 36 -1360 -1430 40 "$AF" "$M"
# Computer
box -1500 -1460 40 -1488 -1420 64 "$PC" "$PC"
# Shelf
box -1584 -1480 80 -1568 -1320 96 "$T" "$T"
box -1584 -1480 96 -1116 -1472 100 "$AF" "$T"
# Neon
neon -1580 -1480 48 -1576 -1320 56 "urban_light/red_light_200"

# Ammo Room EAST (1100,-1500) to (1600,-1300)
room 1100 -1500 1600 -1300 0 160 16 "$WP" "$F"
# Crate stacks
box 1200 -1460 0 1280 -1380 56 "$AC" "$W"
box 1216 -1448 56 1264 -1392 80 "$AC" "$W"
box 1350 -1480 0 1430 -1400 48 "$AC" "$W"
box 1480 -1460 0 1560 -1380 64 "$AC" "$W"
box 1496 -1448 64 1544 -1392 88 "$AC" "$W"
neon 1576 -1480 48 1580 -1320 56 "urban_light/red_light_200"

# Connecting corridor (y=-1400 level)
box -1100 -1440 0 1100 -1360 8 "$F" "$H"
box -1100 -1448 0 1100 -1440 160 "$W" "$W"
box -1100 -1360 0 1100 -1352 160 "$W" "$W"
box -1100 -1440 152 1100 -1360 160 "$H" "$WS"
# Upper walkway z=128 (south wall)
box -800 -1580 120 800 -1560 128 "$AF" "$M"
box -800 -1584 128 800 -1556 132 "$T" "$T"
neon -780 -1564 96 -776 -1564 104 "urban_light/red_light_200"

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// ZONE 3: SOUTH COURTYARD (y=-1200 to -800)" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# Open area with central platform
box -256 -1064 0 256 -936 64 "$AF" "$T"
# Stairs west to platform
box -384 -1032 0 -256 -968 32 "$AF" "$T"
# Stairs east to platform
box 256 -1032 0 384 -968 32 "$AF" "$T"
# L-barriers
box -700 -1100 0 -620 -1020 72 "$W" "$W"
box -700 -1100 0 -580 -1080 40 "$W" "$W"
box 620 -1100 0 700 -1020 72 "$W" "$W"
box 580 -1080 0 700 -1100 40 "$W" "$W"
box -300 -880 0 -220 -820 56 "$W" "$W"
box 220 -880 0 300 -820 56 "$W" "$W"
# Neon floor strips
neon -4 -1180 0 4 -820 4 "urban_light/green_light_100"
# Ceiling over courtyard edges
box -2048 -1200 240 -800 -800 248 "$H" "$WS"
box 800 -1200 240 2048 -800 248 "$H" "$WS"

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// ZONE 4: WEST WING (x=-2048..-800, y=-800..800)" >> "$OUT"
echo "// Armory Room" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# Armory room (-1800,-400) to (-1200,400)
room -1800 -400 -1200 400 0 192 16 "$W" "$F"
# Extra east entrance (gap already from room func at N/S)
# Balcony z=128 (north side)
box -1784 200 120 -1216 384 128 "$AF" "$M"
box -1784 196 128 -1216 200 160 "$T" "$T"
# Stairs to balcony
box -1784 100 0 -1700 200 32 "$AF" "$T"
box -1784 132 32 -1732 200 64 "$AF" "$T"
box -1784 164 64 -1764 200 96 "$AF" "$T"
box -1784 180 96 -1780 200 128 "$AF" "$T"
# Weapon racks (tall thin brushes)
box -1780 -350 0 -1764 -200 128 "$M" "$WP"
box -1780 -100 0 -1764 50 128 "$M" "$WP"
# Crate
box -1400 -300 0 -1340 -240 48 "$AC" "$W"
box -1350 -100 0 -1280 -40 64 "$AC" "$W"
# Neon
neon -1780 -380 80 -1776 380 88 "urban_light/green_light_350"
neon -1220 -380 80 -1216 380 88 "urban_light/green_light_350"

# Corridor to center (-1200,-128) to (-800,128)
box -1200 -144 0 -800 -128 160 "$W" "$W"
box -1200 128 0 -800 144 160 "$W" "$W"
box -1200 -128 152 -800 128 160 "$H" "$WS"
box -1200 -128 0 -800 128 4 "$F" "$H"
neon -1196 -120 80 -1192 120 88 "urban_light/green_light_200"

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// ZONE 5: CENTRAL PLAZA (x=-800..800, y=-800..800)" >> "$OUT"
echo "// Multi-level contested zone" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# Ground level platform z=64
box -256 -256 0 256 256 64 "$AF" "$T"
# Upper platform z=128
box -128 -128 64 128 128 128 "$AF" "$T"
# Stairs to upper (4 sides)
box -256 -288 0 -192 -256 32 "$AF" "$T"
box -192 -288 0 -128 -256 64 "$AF" "$T"
box 192 256 0 256 288 32 "$AF" "$T"
box 128 256 0 192 288 64 "$AF" "$T"
# Cover pillars (4 corners of plaza)
box -600 -600 0 -560 -560 160 "$W" "$W"
box 560 -600 0 600 -560 160 "$W" "$W"
box -600 560 0 -560 600 160 "$W" "$W"
box 560 560 0 600 600 160 "$W" "$W"
# Low walls for cover
box -500 -200 0 -460 200 72 "$W" "$W"
box 460 -200 0 500 200 72 "$W" "$W"
box -200 -500 0 200 -460 56 "$W" "$W"
box -200 460 0 200 500 56 "$W" "$W"
# Neon on upper platform
neon -124 -124 128 -120 124 136 "urban_light/blue_light_500"
neon 120 -124 128 124 124 136 "urban_light/blue_light_500"
neon -120 -128 64 120 -124 72 "urban_light/green_light_200"
neon -120 124 64 120 128 72 "urban_light/green_light_200"
# Underground tunnel entrance (west)
box -840 -96 -72 -800 96 0 "$F" "$M"
box -844 -96 -72 -840 96 0 "$M" "$M"
box -840 -100 -72 -800 -96 0 "$M" "$M"
box -840 96 -72 -800 100 0 "$M" "$M"
# Underground tunnel entrance (east)
box 800 -96 -72 840 96 0 "$F" "$M"
box 840 -96 -72 844 96 0 "$M" "$M"
box 800 -100 -72 840 -96 0 "$M" "$M"
box 800 96 -72 840 100 0 "$M" "$M"

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// ZONE 6: EAST WING (x=800..2048, y=-800..800)" >> "$OUT"
echo "// Storage/Server Room" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# Server room (1200,-400) to (1800,400)
room 1200 -400 1800 400 0 192 16 "$W" "$F"
# Server racks (tall thin brushes, 6 racks)
for y in -300 -180 -60 60 180 300; do
    box 1300 $((y-8)) 0 1316 $((y+8)) 160 "$WP" "$M"
done
# Upper walkway z=128 (south side)
box 1216 -384 120 1784 -200 128 "$AF" "$M"
box 1216 -200 128 1784 -196 160 "$T" "$T"
# Stairs to walkway
box 1700 -200 0 1784 -100 32 "$AF" "$T"
box 1732 -200 32 1784 -132 64 "$AF" "$T"
box 1764 -200 64 1784 -164 96 "$AF" "$T"
box 1780 -200 96 1784 -180 128 "$AF" "$T"
# Neon
neon 1220 -380 80 1224 380 88 "urban_light/red_light_350"
neon 1776 -380 80 1780 380 88 "urban_light/red_light_350"

# Corridor to center (800,-128) to (1200,128)
box 800 -144 0 1200 -128 160 "$W" "$W"
box 800 128 0 1200 144 160 "$W" "$W"
box 800 -128 152 1200 128 160 "$H" "$WS"
box 800 -128 0 1200 128 4 "$F" "$H"
neon 804 -120 80 808 120 88 "urban_light/red_light_200"

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// ZONE 7: UNDERGROUND TUNNEL (z=-64..0)" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# Tunnel floor
box -800 -96 -72 800 96 -64 "$F" "$H"
# Tunnel ceiling (= main floor at z=0, already exists)
# Tunnel walls
box -800 -112 -64 800 -96 0 "$WS" "$WS"
box -800 96 -64 800 112 0 "$WS" "$WS"
# Support pillars
for x in -600 -300 0 300 600; do
    box $((x-16)) -96 -64 $((x+16)) 96 0 "$M" "$M"
done
# Neon strips
neon -796 -88 -32 -792 88 -24 "urban_light/blue_light_500"
neon 792 -88 -32 796 88 -24 "urban_light/blue_light_500"
neon -400 -108 -48 -396 108 -40 "urban_light/green_light_200"
neon 396 -108 -48 400 108 -40 "urban_light/green_light_200"

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// ZONE 8: NORTH COURTYARD (y=800..1200)" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# Central platform
box -256 936 0 256 1064 64 "$AF" "$T"
# Stairs
box -384 968 0 -256 1032 32 "$AF" "$T"
box 256 968 0 384 1032 32 "$AF" "$T"
# Cover (asymmetric from south)
box -500 900 0 -420 980 72 "$W" "$W"
box 600 1020 0 680 1100 72 "$W" "$W"
box -200 1100 0 -120 1160 56 "$W" "$W"
box 120 840 0 200 900 56 "$W" "$W"
# Neon
neon -4 820 0 4 1180 4 "urban_light/green_light_100"
# Ceilings over edges
box -2048 800 240 -800 1200 248 "$H" "$WS"
box 800 800 240 2048 1200 248 "$H" "$WS"

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// ZONE 9: BLUE BASE (y=1600..2048) — mirror of red" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# Flag room
room -192 1700 192 1900 0 192 16 "$W" "$AF"
# Platform behind flag
box -128 1900 0 128 2032 48 "$AF" "$T"
# Side alcoves
box -448 1800 0 -256 2032 128 "$W" "$W"
box -440 1808 0 -264 2024 8 "$AF" "$H"
box -440 1808 120 -264 2024 128 "$H" "$H"
box 256 1800 0 448 2032 128 "$W" "$W"
box 264 1808 0 440 2024 8 "$AF" "$H"
box 264 1808 120 440 2024 128 "$H" "$H"
# Neon
neon -188 1720 96 -184 1880 104 "urban_light/blue_light_500"
neon 184 1720 96 188 1880 104 "urban_light/blue_light_500"
# Ceiling
box -512 1600 184 512 2048 192 "$H" "$WS"
# Corridor to courtyard
box -128 1600 0 128 1700 8 "$F" "$H"
box -144 1600 0 -128 1700 192 "$W" "$W"
box 128 1600 0 144 1700 192 "$W" "$W"
box -128 1600 176 128 1700 184 "$H" "$H"
# Trim
box -192 1700 0 192 1708 4 "$T" "$T"
box -192 1892 0 192 1900 4 "$T" "$T"

# Blue side rooms
# Server Room WEST (-1600,1300) to (-1100,1500)
room -1600 1300 -1100 1500 0 160 16 "$WP" "$F"
box -1500 1340 0 -1350 1380 36 "$AF" "$M"
box -1490 1350 36 -1360 1370 40 "$AF" "$M"
box -1500 1340 40 -1488 1380 64 "$PC" "$PC"
box -1584 1320 80 -1568 1480 96 "$T" "$T"
box -1584 1320 96 -1116 1328 100 "$AF" "$T"
neon -1580 1320 48 -1576 1480 56 "urban_light/blue_light_200"

# Storage Room EAST (1100,1300) to (1600,1500)
room 1100 1300 1600 1500 0 160 16 "$WP" "$F"
box 1200 1340 0 1280 1420 56 "$AC" "$W"
box 1216 1352 56 1264 1408 80 "$AC" "$W"
box 1350 1320 0 1430 1400 48 "$AC" "$W"
box 1480 1340 0 1560 1420 64 "$AC" "$W"
neon 1576 1320 48 1580 1480 56 "urban_light/blue_light_200"

# Connecting corridor
box -1100 1360 0 1100 1440 8 "$F" "$H"
box -1100 1352 0 1100 1360 160 "$W" "$W"
box -1100 1440 0 1100 1448 160 "$W" "$W"
box -1100 1360 152 1100 1440 160 "$H" "$WS"
# Upper walkway
box -800 1560 120 800 1580 128 "$AF" "$M"
box -800 1556 128 800 1584 132 "$T" "$T"

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// CONNECTING CORRIDORS between zones" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# West wing to south courtyard
box -1816 -800 0 -1784 -400 4 "$F" "$H"
box -1820 -800 0 -1816 -400 192 "$W" "$W"
box -1784 -800 0 -1780 -400 192 "$W" "$W"
box -1816 -800 184 -1784 -400 192 "$H" "$WS"

# West wing to north courtyard
box -1816 400 0 -1784 800 4 "$F" "$H"
box -1820 400 0 -1816 800 192 "$W" "$W"
box -1784 400 0 -1780 800 192 "$W" "$W"
box -1816 400 184 -1784 800 192 "$H" "$WS"

# East wing to south courtyard
box 1784 -800 0 1816 -400 4 "$F" "$H"
box 1780 -800 0 1784 -400 192 "$W" "$W"
box 1816 -800 0 1820 -400 192 "$W" "$W"
box 1784 -800 184 1816 -400 192 "$H" "$WS"

# East wing to north courtyard
box 1784 400 0 1816 800 4 "$F" "$H"
box 1780 400 0 1784 800 192 "$W" "$W"
box 1816 400 0 1820 800 192 "$W" "$W"
box 1784 400 184 1816 800 192 "$H" "$WS"

# Side paths base-to-siderooms (wider passages)
box -800 -1600 0 -512 -1200 4 "$F" "$H"
box 512 -1600 0 800 -1200 4 "$F" "$H"
box -800 1200 0 -512 1600 4 "$F" "$H"
box 512 1200 0 800 1600 4 "$F" "$H"

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// TRIM + DETAIL throughout" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# Pillar trim rings (central plaza)
for x in -600 600; do
    for y in -600 600; do
        box $((x-24)) $((y-24)) 0 $((x+24)) $((y+24)) 4 "$T" "$T"
        box $((x-24)) $((y-24)) 156 $((x+24)) $((y+24)) 160 "$T" "$T"
    done
done

# Pipes in corridors
box -798 -140 144 -802 140 152 "$M" "$M"
box 798 -140 144 802 140 152 "$M" "$M"
box -140 -798 200 140 -802 208 "$M" "$M"
box -140 798 200 140 802 208 "$M" "$M"

echo "" >> "$OUT"
echo "} // END WORLDSPAWN" >> "$OUT"

# ================================================================
# ENTITIES
# ================================================================
cat >> "$OUT" << 'ENTITIES'

// CTF FLAGS
{
"classname" "team_CTF_redflag"
"origin" "0 -1800 16"
"angle" "90"
}
{
"classname" "team_CTF_blueflag"
"origin" "0 1800 16"
"angle" "270"
}

// RED SPAWNS x16
{
"classname" "info_ut_spawn"
"origin" "-350 -1950 16"
"angle" "90"
"team" "red"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "-200 -1950 16"
"angle" "90"
"team" "red"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "0 -1950 16"
"angle" "90"
"team" "red"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "200 -1950 16"
"angle" "90"
"team" "red"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "350 -1950 16"
"angle" "90"
"team" "red"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "-350 -2000 16"
"angle" "90"
"team" "red"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "-200 -2000 16"
"angle" "90"
"team" "red"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "0 -2000 16"
"angle" "90"
"team" "red"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "200 -2000 16"
"angle" "90"
"team" "red"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "350 -2000 16"
"angle" "90"
"team" "red"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "-100 -1850 16"
"angle" "90"
"team" "red"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "100 -1850 16"
"angle" "90"
"team" "red"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "-300 -1850 16"
"angle" "45"
"team" "red"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "300 -1850 16"
"angle" "135"
"team" "red"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "-150 -1750 16"
"angle" "90"
"team" "red"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "150 -1750 16"
"angle" "90"
"team" "red"
"g_gametype" "3,4,5,7"
}

// BLUE SPAWNS x16
{
"classname" "info_ut_spawn"
"origin" "-350 1950 16"
"angle" "270"
"team" "blue"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "-200 1950 16"
"angle" "270"
"team" "blue"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "0 1950 16"
"angle" "270"
"team" "blue"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "200 1950 16"
"angle" "270"
"team" "blue"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "350 1950 16"
"angle" "270"
"team" "blue"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "-350 2000 16"
"angle" "270"
"team" "blue"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "-200 2000 16"
"angle" "270"
"team" "blue"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "0 2000 16"
"angle" "270"
"team" "blue"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "200 2000 16"
"angle" "270"
"team" "blue"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "350 2000 16"
"angle" "270"
"team" "blue"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "-100 1850 16"
"angle" "270"
"team" "blue"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "100 1850 16"
"angle" "270"
"team" "blue"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "-300 1850 16"
"angle" "315"
"team" "blue"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "300 1850 16"
"angle" "225"
"team" "blue"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "-150 1750 16"
"angle" "270"
"team" "blue"
"g_gametype" "3,4,5,7"
}
{
"classname" "info_ut_spawn"
"origin" "150 1750 16"
"angle" "270"
"team" "blue"
"g_gametype" "3,4,5,7"
}

// FFA SPAWNS x8
{
"classname" "info_player_deathmatch"
"origin" "-500 0 16"
"angle" "0"
}
{
"classname" "info_player_deathmatch"
"origin" "500 0 16"
"angle" "180"
}
{
"classname" "info_player_deathmatch"
"origin" "0 -400 16"
"angle" "90"
}
{
"classname" "info_player_deathmatch"
"origin" "0 400 16"
"angle" "270"
}
{
"classname" "info_player_deathmatch"
"origin" "-1500 0 16"
"angle" "0"
}
{
"classname" "info_player_deathmatch"
"origin" "1500 0 16"
"angle" "180"
}
{
"classname" "info_player_deathmatch"
"origin" "0 -1000 16"
"angle" "90"
}
{
"classname" "info_player_deathmatch"
"origin" "0 1000 16"
"angle" "270"
}

// TARGET LOCATIONS
{
"classname" "target_location"
"message" "Red Base"
"origin" "0 -1800 40"
}
{
"classname" "target_location"
"message" "Blue Base"
"origin" "0 1800 40"
}
{
"classname" "target_location"
"message" "Central Plaza"
"origin" "0 0 80"
}
{
"classname" "target_location"
"message" "Armory"
"origin" "-1500 0 40"
}
{
"classname" "target_location"
"message" "Server Room"
"origin" "1500 0 40"
}
{
"classname" "target_location"
"message" "Control Room"
"origin" "-1350 -1400 40"
}
{
"classname" "target_location"
"message" "Red Ammo"
"origin" "1350 -1400 40"
}
{
"classname" "target_location"
"message" "Blue Server"
"origin" "-1350 1400 40"
}
{
"classname" "target_location"
"message" "Blue Storage"
"origin" "1350 1400 40"
}
{
"classname" "target_location"
"message" "South Courtyard"
"origin" "0 -1000 40"
}
{
"classname" "target_location"
"message" "North Courtyard"
"origin" "0 1000 40"
}
{
"classname" "target_location"
"message" "Underground"
"origin" "0 0 -40"
}

// LIGHTS
{
"classname" "light"
"origin" "0 -1800 160"
"light" "250"
"_color" "1.0 0.3 0.1"
}
{
"classname" "light"
"origin" "0 1800 160"
"light" "250"
"_color" "0.1 0.3 1.0"
}
{
"classname" "light"
"origin" "0 0 180"
"light" "300"
"_color" "0.2 0.8 1.0"
}
{
"classname" "light"
"origin" "-1500 0 160"
"light" "200"
"_color" "0.2 1.0 0.3"
}
{
"classname" "light"
"origin" "1500 0 160"
"light" "200"
"_color" "1.0 0.2 0.2"
}
{
"classname" "light"
"origin" "0 -1000 160"
"light" "180"
"_color" "0.2 1.0 0.3"
}
{
"classname" "light"
"origin" "0 1000 160"
"light" "180"
"_color" "0.2 1.0 0.3"
}
{
"classname" "light"
"origin" "0 0 -32"
"light" "150"
"_color" "0.0 0.8 1.0"
}
{
"classname" "light"
"origin" "-1350 -1400 120"
"light" "160"
"_color" "1.0 0.3 0.1"
}
{
"classname" "light"
"origin" "1350 -1400 120"
"light" "160"
"_color" "1.0 0.3 0.1"
}
{
"classname" "light"
"origin" "-1350 1400 120"
"light" "160"
"_color" "0.1 0.3 1.0"
}
{
"classname" "light"
"origin" "1350 1400 120"
"light" "160"
"_color" "0.1 0.3 1.0"
}
{
"classname" "light"
"origin" "-400 -1000 120"
"light" "120"
"_color" "0.2 1.0 0.3"
}
{
"classname" "light"
"origin" "400 -1000 120"
"light" "120"
"_color" "0.2 1.0 0.3"
}
{
"classname" "light"
"origin" "-400 1000 120"
"light" "120"
"_color" "0.2 1.0 0.3"
}
{
"classname" "light"
"origin" "400 1000 120"
"light" "120"
"_color" "0.2 1.0 0.3"
}

// AMBIENT SOUNDS
{
"classname" "target_speaker"
"origin" "0 0 -32"
"noise" "sound/ricochet/water.wav"
"spawnflags" "1"
"wait" "20"
"random" "5"
}
{
"classname" "target_speaker"
"origin" "-1500 0 80"
"noise" "sound/ricochet/water.wav"
"spawnflags" "1"
"wait" "30"
"random" "8"
}
{
"classname" "target_speaker"
"origin" "1500 0 80"
"noise" "sound/ricochet/water.wav"
"spawnflags" "1"
"wait" "30"
"random" "8"
}
{
"classname" "target_speaker"
"origin" "0 -1800 80"
"noise" "sound/ricochet/water.wav"
"spawnflags" "1"
"wait" "25"
"random" "5"
}
{
"classname" "target_speaker"
"origin" "0 1800 80"
"noise" "sound/ricochet/water.wav"
"spawnflags" "1"
"wait" "25"
"random" "5"
}

// INTERMISSION
{
"classname" "info_player_intermission"
"origin" "0 0 350"
"angle" "270"
}
ENTITIES

COUNT=$(grep -c "^{" "$OUT")
echo "=== MAP GENERATED: $COUNT total braces ==="
