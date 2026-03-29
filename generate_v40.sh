#!/bin/bash
# v40 MASSIVE ROOM GENERATOR — 400+ brushes
# Creates REAL enclosed rooms, varied textures, clip, furniture
OUT="v40_brushes.txt"
> "$OUT"

# === BRUSH HELPERS ===
box() {
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 top=$7 side=$8
    [ -z "$side" ] && side="$top"
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
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 face=$7 tex=$8
    # face: px=+x, nx=-x, py=+y, ny=-y
    local t1="metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0"
    local tn="$tex 0 0 0 0.5 0.5 0 0 0"
    local fx="$t1"; local fnx="$t1"; local fy="$t1"; local fny="$t1"
    case $face in
        px) fx="$tn" ;; nx) fnx="$tn" ;; py) fy="$tn" ;; ny) fny="$tn" ;;
    esac
    cat >> "$OUT" << EOF
{
( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) $t1
( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) $t1
( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) $fnx
( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) $fx
( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) $fny
( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) $fy
}
EOF
}

# room: floor + ceiling + 4 walls (with optional gap on south/north for doorway)
# room x1 y1 x2 y2 z_floor z_ceil thickness wall_tex floor_tex ceil_tex
room() {
    local x1=$1 y1=$2 x2=$3 y2=$4 zf=$5 zc=$6 t=$7 wt=$8 ft=$9 ct=${10}
    local xi1=$((x1+t)) yi1=$((y1+t)) xi2=$((x2-t)) yi2=$((y2-t))
    # Floor
    box $x1 $y1 $((zf-8)) $x2 $y2 $zf "$ft" "metal/metal_darkgrey"
    # Ceiling
    box $x1 $y1 $zc $x2 $y2 $((zc+8)) "metal/metal_darkgrey" "$ct"
    # West wall
    box $x1 $y1 $zf $xi1 $y2 $zc "$wt" "$wt"
    # East wall
    box $xi2 $y1 $zf $x2 $y2 $zc "$wt" "$wt"
    # South wall left half
    box $xi1 $y1 $zf $((x1+(x2-x1)/3)) $yi1 $zc "$wt" "$wt"
    # South wall right half
    box $((x2-(x2-x1)/3)) $y1 $zf $xi2 $yi1 $zc "$wt" "$wt"
    # North wall left half
    box $xi1 $yi2 $zf $((x1+(x2-x1)/3)) $y2 $zc "$wt" "$wt"
    # North wall right half
    box $((x2-(x2-x1)/3)) $yi2 $zf $xi2 $y2 $zc "$wt" "$wt"
}

# Textures by zone
W_IND="tech1soc_wall/grill_wall03a"     # industrial
W_CLEAN="tech1soc_wall/half_grill_wall01a"  # clean industrial
W_WARM="tech1soc_wall/half_grill_wall02a"   # warm panels
W_TRIM="tech1soc_trim/032-01a"
F_TECH="tech1soc_floor/block01a"
F_METAL="metal/metal_darkgrey"
C_DARK="metal/metal_darkgrey"
SW14="sweetnutz/sn_wall14"
SW_DOOR="sweetnutz/sn_door7"

echo "// v40 — MASSIVE ROOM + CORRIDOR + FURNITURE GENERATION" >> "$OUT"

# ============================================================
echo "// === ZONE A: COMMAND ROOMS (2 enclosed rooms flanking bases) ===" >> "$OUT"
echo "// Red side command rooms" >> "$OUT"

# Red west command room (-1024,-1800) to (-768,-1600) z=0-160
room -1024 -1800 -768 -1600 0 160 16 "$SW14" "$F_TECH" "$C_DARK"
# Furniture: desk
box -960 -1760 0 -832 -1728 40 "$F_TECH" "$W_TRIM"
# Chair (small)
box -900 -1720 0 -868 -1700 32 "$F_METAL" "$W_TRIM"
# Shelf on wall
box -1008 -1780 96 -992 -1620 112 "$F_TECH" "$W_TRIM"
# Neon inside
neon -1004 -1780 64 -1000 -1620 72 px "urban_light/red_light_200"

# Red east command room (768,-1800) to (1024,-1600) z=0-160
room 768 -1800 1024 -1600 0 160 16 "$SW14" "$F_TECH" "$C_DARK"
box 832 -1760 0 960 -1728 40 "$F_TECH" "$W_TRIM"
box 868 -1720 0 900 -1700 32 "$F_METAL" "$W_TRIM"
box 992 -1780 96 1008 -1620 112 "$F_TECH" "$W_TRIM"
neon 1000 -1780 64 1004 -1620 72 nx "urban_light/red_light_200"

echo "// Blue side command rooms" >> "$OUT"
room -1024 1600 -768 1800 0 160 16 "$SW14" "$F_TECH" "$C_DARK"
box -960 1728 0 -832 1760 40 "$F_TECH" "$W_TRIM"
box -900 1700 0 -868 1720 32 "$F_METAL" "$W_TRIM"
box -1008 1620 96 -992 1780 112 "$F_TECH" "$W_TRIM"
neon -1004 1620 64 -1000 1780 72 px "urban_light/blue_light_200"

room 768 1600 1024 1800 0 160 16 "$SW14" "$F_TECH" "$C_DARK"
box 832 1728 0 960 1760 40 "$F_TECH" "$W_TRIM"
box 868 1700 0 900 1720 32 "$F_METAL" "$W_TRIM"
box 992 1620 96 1008 1780 112 "$F_TECH" "$W_TRIM"
neon 1000 1620 64 1004 1780 72 nx "urban_light/blue_light_200"

# ============================================================
echo "" >> "$OUT"
echo "// === ZONE B: STORAGE ROOMS (outer area, crates + shelves) ===" >> "$OUT"

# West storage south (-1536,-1200) to (-1280,-800) z=0-176
room -1536 -1200 -1280 -800 0 176 16 "$W_IND" "$F_TECH" "$C_DARK"
# Crate stack 1
box -1500 -1100 0 -1440 -1040 64 "$F_TECH" "$W_IND"
box -1490 -1090 64 -1450 -1050 96 "$F_TECH" "$W_IND"
# Crate stack 2
box -1380 -1150 0 -1320 -1090 48 "$F_TECH" "$W_IND"
# Long shelf
box -1520 -900 0 -1504 -820 128 "$F_TECH" "$W_TRIM"
box -1520 -900 128 -1296 -884 136 "$F_TECH" "$W_TRIM"
# Neon
neon -1520 -1050 100 -1516 -850 108 px "urban_light/green_light_200"

# East storage south (mirror)
room 1280 -1200 1536 -800 0 176 16 "$W_IND" "$F_TECH" "$C_DARK"
box 1440 -1100 0 1500 -1040 64 "$F_TECH" "$W_IND"
box 1450 -1090 64 1490 -1050 96 "$F_TECH" "$W_IND"
box 1320 -1150 0 1380 -1090 48 "$F_TECH" "$W_IND"
box 1504 -900 0 1520 -820 128 "$F_TECH" "$W_TRIM"
box 1296 -900 128 1520 -884 136 "$F_TECH" "$W_TRIM"
neon 1516 -1050 100 1520 -850 108 nx "urban_light/red_light_200"

# West storage north
room -1536 800 -1280 1200 0 176 16 "$W_IND" "$F_TECH" "$C_DARK"
box -1500 1040 0 -1440 1100 64 "$F_TECH" "$W_IND"
box -1490 1050 64 -1450 1090 96 "$F_TECH" "$W_IND"
box -1380 1090 0 -1320 1150 48 "$F_TECH" "$W_IND"
box -1520 820 0 -1504 900 128 "$F_TECH" "$W_TRIM"
box -1520 884 128 -1296 900 136 "$F_TECH" "$W_TRIM"
neon -1520 850 100 -1516 1050 108 px "urban_light/green_light_200"

# East storage north
room 1280 800 1536 1200 0 176 16 "$W_IND" "$F_TECH" "$C_DARK"
box 1440 1040 0 1500 1100 64 "$F_TECH" "$W_IND"
box 1450 1050 64 1490 1090 96 "$F_TECH" "$W_IND"
box 1320 1090 0 1380 1150 48 "$F_TECH" "$W_IND"
box 1504 820 0 1520 900 128 "$F_TECH" "$W_TRIM"
box 1296 884 128 1520 900 136 "$F_TECH" "$W_TRIM"
neon 1516 850 100 1520 1050 108 nx "urban_light/red_light_200"

# ============================================================
echo "" >> "$OUT"
echo "// === ZONE C: CORRIDOR ROOMS (small rooms off main corridor) ===" >> "$OUT"

# 4 small rooms off corridor walls
# West side y=-800 room
room -640 -864 -528 -736 0 144 16 "$W_CLEAN" "$F_TECH" "$C_DARK"
box -608 -840 0 -560 -808 40 "$F_TECH" "$W_TRIM"
neon -624 -848 80 -620 -752 88 px "urban_light/blue_light_200"

# West side y=800 room
room -640 736 -528 864 0 144 16 "$W_CLEAN" "$F_TECH" "$C_DARK"
box -608 808 0 -560 840 40 "$F_TECH" "$W_TRIM"
neon -624 752 80 -620 848 88 px "urban_light/blue_light_200"

# East side y=-800 room
room 528 -864 640 -736 0 144 16 "$W_CLEAN" "$F_TECH" "$C_DARK"
box 560 -840 0 608 -808 40 "$F_TECH" "$W_TRIM"
neon 620 -848 80 624 -752 88 nx "urban_light/blue_light_200"

# East side y=800 room
room 528 736 640 864 0 144 16 "$W_CLEAN" "$F_TECH" "$C_DARK"
box 560 808 0 608 840 40 "$F_TECH" "$W_TRIM"
neon 620 752 80 624 848 88 nx "urban_light/blue_light_200"

# ============================================================
echo "" >> "$OUT"
echo "// === ZONE D: ELEVATED SNIPER PERCH (z=192 rooms) ===" >> "$OUT"

# West sniper room (-1024,-160) to (-800,160) z=192-320
box -1024 -160 184 -800 160 192 "$F_TECH" "$W_WARM"
box -1024 -160 312 -800 160 320 "$C_DARK" "$C_DARK"
box -1024 -160 192 -1008 160 312 "$W_WARM" "$W_WARM"
box -816 -160 192 -800 160 312 "$W_WARM" "$W_WARM"
box -1008 -160 192 -816 -144 312 "$W_WARM" "$W_WARM"
box -1008 144 192 -816 160 312 "$W_WARM" "$W_WARM"
# Window opening (gap in east wall for sniping)
box -816 -64 192 -800 -16 252 "$W_TRIM" "$W_TRIM"
box -816 16 192 -800 64 252 "$W_TRIM" "$W_TRIM"
box -816 -64 288 -800 64 312 "$W_TRIM" "$W_TRIM"
neon -812 -56 256 -808 56 264 nx "urban_light/green_light_350"

# East sniper room (mirror)
box 800 -160 1024 160 184 192 "$F_TECH" "$W_WARM"
box 800 -160 1024 160 312 320 "$C_DARK" "$C_DARK"
box 800 -160 192 816 160 312 "$W_WARM" "$W_WARM"
box 1008 -160 192 1024 160 312 "$W_WARM" "$W_WARM"
box 816 -160 192 1008 -144 312 "$W_WARM" "$W_WARM"
box 816 144 192 1008 160 312 "$W_WARM" "$W_WARM"
box 800 -64 192 816 -16 252 "$W_TRIM" "$W_TRIM"
box 800 16 192 816 64 252 "$W_TRIM" "$W_TRIM"
box 800 -64 288 816 64 312 "$W_TRIM" "$W_TRIM"
neon 808 -56 256 812 56 264 px "urban_light/red_light_350"

# ============================================================
echo "" >> "$OUT"
echo "// === ZONE E: APPROACH TUNNELS (enclosed passages to bases) ===" >> "$OUT"

# Red approach tunnel — enclosed corridor y=-1400..-1280, x=-384..384
box -384 -1408 0 384 -1400 8 "$F_TECH" "$F_METAL"       # floor
box -384 -1408 144 384 -1400 152 "$C_DARK" "$C_DARK"      # ceiling
box -384 -1288 0 384 -1280 8 "$F_TECH" "$F_METAL"        # floor 2
box -384 -1288 144 384 -1280 152 "$C_DARK" "$C_DARK"       # ceiling 2
# Tunnel walls
box -400 -1408 0 -384 -1280 152 "$SW14" "$SW14"
box 384 -1408 0 400 -1280 152 "$SW14" "$SW14"
# Tunnel ceiling
box -384 -1400 144 384 -1280 152 "$C_DARK" "$C_DARK"
# Neons inside tunnel
neon -396 -1390 80 -392 -1290 88 px "urban_light/red_light_350"
neon 392 -1390 80 396 -1290 88 nx "urban_light/red_light_350"

# Blue approach tunnel
box -400 1280 0 -384 1408 152 "$SW14" "$SW14"
box 384 1280 0 400 1408 152 "$SW14" "$SW14"
box -384 1280 144 384 1400 152 "$C_DARK" "$C_DARK"
neon -396 1290 80 -392 1390 88 px "urban_light/blue_light_350"
neon 392 1290 80 396 1390 88 nx "urban_light/blue_light_350"

# ============================================================
echo "" >> "$OUT"
echo "// === ZONE F: ADDITIONAL COVER + FURNITURE throughout ===" >> "$OUT"

# Barricades in approach zones (L-shaped for tactical play)
# Red approach
box -256 -1500 0 -192 -1420 80 "$W_IND" "$W_IND"
box -256 -1500 0 -128 -1484 48 "$W_IND" "$W_IND"
box 192 -1500 0 256 -1420 80 "$W_IND" "$W_IND"
box 128 -1500 0 256 -1484 48 "$W_IND" "$W_IND"
# Blue approach
box -256 1420 0 -192 1500 80 "$W_IND" "$W_IND"
box -256 1484 0 -128 1500 48 "$W_IND" "$W_IND"
box 192 1420 0 256 1500 80 "$W_IND" "$W_IND"
box 128 1484 0 256 1500 48 "$W_IND" "$W_IND"

# Scattered cover in flanks
for y in -600 -200 200 600; do
    box -880 $((y-24)) 0 -832 $((y+24)) 64 "$W_IND" "$W_WARM"
    box 832 $((y-24)) 0 880 $((y+24)) 64 "$W_IND" "$W_WARM"
done

# Mid-map low walls for competitive play
box -160 -380 0 -128 -280 72 "$W_CLEAN" "$W_CLEAN"
box 128 280 0 160 380 72 "$W_CLEAN" "$W_CLEAN"
box -160 280 0 -128 380 72 "$W_CLEAN" "$W_CLEAN"
box 128 -380 0 160 -280 72 "$W_CLEAN" "$W_CLEAN"

# ============================================================
echo "" >> "$OUT"
echo "// === ZONE G: STAIRS to sniper perch (z=0-192) ===" >> "$OUT"

# West stairs to sniper perch (8 steps of 24u each)
for i in $(seq 0 7); do
    z2=$(( (i+1)*24 ))
    x2=$((-800 - 16 - i*16))
    x1=$((-800 - 16 - (i+1)*16))
    box $x1 -48 0 $x2 48 $z2 "$F_TECH" "$W_TRIM"
done

# East stairs
for i in $(seq 0 7); do
    z2=$(( (i+1)*24 ))
    x1=$((800 + 16 + i*16))
    x2=$((800 + 16 + (i+1)*16))
    box $x1 -48 0 $x2 48 $z2 "$F_TECH" "$W_TRIM"
done

# ============================================================
echo "" >> "$OUT"
echo "// === ADDITIONAL LIGHTS for new rooms ===" >> "$OUT"

# Command room lights (appended as entities later)
# Storage room lights
# These will be added as entities in the entity section

COUNT=$(grep -c "^{" "$OUT")
echo "" >> "$OUT"
echo "// Total v40 brushes: $COUNT" >> "$OUT"
echo "Generated $COUNT brushes in $OUT"
