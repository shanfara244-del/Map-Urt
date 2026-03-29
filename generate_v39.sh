#!/bin/bash
# v39 MEGA — Competitive corridor layout generator
# Creates ENCLOSED corridors, rooms, staircases, and competitive geometry
# Target: 250+ new brushes

OUT="v39_brushes.txt"
echo "" > "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// v39 — COMPETITIVE LAYOUT: enclosed corridors, rooms, stairs" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# Brush helper: floor+ceiling+walls = enclosed corridor section
# corridor_section x1 y1 x2 y2 z_floor z_ceil wall_tex floor_tex ceil_tex
corridor_section() {
    local x1=$1 y1=$2 x2=$3 y2=$4 zf=$5 zc=$6 wtex=$7 ftex=$8 ctex=$9
    local zf2=$((zf+8))
    local zc2=$((zc-8))
    # Floor
    echo "{" >> "$OUT"
    echo "( $x1 $y2 $zf ) ( $x1 $y1 $zf ) ( $x2 $y1 $zf ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $zf2 ) ( $x2 $y1 $zf2 ) ( $x1 $y1 $zf2 ) $ftex 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x1 $y1 $zf2 ) ( $x1 $y1 $zf ) ( $x1 $y2 $zf ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $zf2 ) ( $x2 $y2 $zf ) ( $x2 $y1 $zf ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y1 $zf ) ( $x1 $y1 $zf ) ( $x1 $y1 $zf2 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $zf2 ) ( $x1 $y2 $zf2 ) ( $x1 $y2 $zf ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "}" >> "$OUT"
    # Ceiling
    echo "{" >> "$OUT"
    echo "( $x1 $y2 $zc2 ) ( $x1 $y1 $zc2 ) ( $x2 $y1 $zc2 ) $ctex 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $zc ) ( $x2 $y1 $zc ) ( $x1 $y1 $zc ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x1 $y1 $zc ) ( $x1 $y1 $zc2 ) ( $x1 $y2 $zc2 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $zc ) ( $x2 $y2 $zc2 ) ( $x2 $y1 $zc2 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y1 $zc2 ) ( $x1 $y1 $zc2 ) ( $x1 $y1 $zc ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $zc ) ( $x1 $y2 $zc ) ( $x1 $y2 $zc2 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "}" >> "$OUT"
}

# Wall brush
wall() {
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 tex_in=$7 tex_out=$8
    echo "{" >> "$OUT"
    echo "( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) $tex_out 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) $tex_in 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) $tex_in 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) $tex_out 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "}" >> "$OUT"
}

# Simple box
box() {
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 tex=$7
    echo "{" >> "$OUT"
    echo "( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) $tex 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) $tex 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) $tex 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) $tex 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) $tex 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "}" >> "$OUT"
}

# Neon strip (visible on +x face)
neon_px() {
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 ntex=$7
    echo "{" >> "$OUT"
    echo "( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) $ntex 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "}" >> "$OUT"
}

# Neon strip (visible on -x face)
neon_nx() {
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 ntex=$7
    echo "{" >> "$OUT"
    echo "( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) $ntex 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "}" >> "$OUT"
}

W1="tech1soc_wall/grill_wall03a"
W2="tech1soc_wall/half_grill_wall01a"
W3="tech1soc_wall/half_grill_wall02a"
F1="tech1soc_floor/block01a"
T1="tech1soc_trim/032-01a"
M="metal/metal_darkgrey"
SW="sweetnutz/sn_wall14"

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// WEST SIDE CORRIDOR — enclosed tunnel x=-1024..-768" >> "$OUT"
echo "// Low ceiling at z=160 (creates claustrophobic flanking route)" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# West side corridor ceilings (5 sections)
for y_start in -1200 -800 -400 0 400 800; do
    y_end=$((y_start+400))
    [ $y_start -eq 800 ] && y_end=1200
    corridor_section -1024 $y_start -768 $y_end 0 160 "$W1" "$F1" "$M"
done

echo "" >> "$OUT"
echo "// EAST SIDE CORRIDOR — enclosed tunnel x=768..1024" >> "$OUT"
for y_start in -1200 -800 -400 0 400 800; do
    y_end=$((y_start+400))
    [ $y_start -eq 800 ] && y_end=1200
    corridor_section 768 $y_start 1024 $y_end 0 160 "$W1" "$F1" "$M"
done

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// WEST OUTER CORRIDOR — enclosed tunnel x=-1536..-1280" >> "$OUT"
echo "// Different texture (sweetnutz) for variety" >> "$OUT"
echo "// ============================================================" >> "$OUT"
for y_start in -1100 -700 -300 300 700; do
    y_end=$((y_start+400))
    corridor_section -1536 $y_start -1280 $y_end 0 176 "$SW" "$F1" "$M"
done

echo "" >> "$OUT"
echo "// EAST OUTER CORRIDOR" >> "$OUT"
for y_start in -1100 -700 -300 300 700; do
    y_end=$((y_start+400))
    corridor_section 1280 $y_start 1536 $y_end 0 176 "$SW" "$F1" "$M"
done

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// CONNECTING TUNNELS (between inner walkway and outer rooms)" >> "$OUT"
echo "// Short enclosed passages at y=-800, -200, 200, 800" >> "$OUT"
echo "// ============================================================" >> "$OUT"
for y in -832 -232 232 832; do
    y2=$((y+64))
    # West connectors
    wall -1280 $y 0 -1264 $y2 160 "$W2" "$W1"  # south wall
    wall -1280 $y 152 -1024 $y2 160 "$M" "$M"   # ceiling connector
    # East connectors
    wall 1024 $y 152 1280 $y2 160 "$M" "$M"     # ceiling connector
    wall 1264 $y 0 1280 $y2 160 "$W1" "$W2"     # south wall
done

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// COMPETITIVE COVER — angled walls for sightline breaks" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# Angled cover in main corridor
for y in -1000 -600 -200 200 600 1000; do
    box -440 $((y-8)) 0 -400 $((y+8)) 112 "$W1"
    box 400 $((y-8)) 0 440 $((y+8)) 112 "$W1"
done

# Low cover in approach zones
for y in -1600 -1400 1400 1600; do
    box -320 $((y-24)) 0 -256 $((y+24)) 56 "$W3"
    box 256 $((y-24)) 0 320 $((y+24)) 56 "$W3"
done

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// SNIPER WINDOWS — openings in corridor walls for long sightlines" >> "$OUT"
echo "// Window frame: thin strips above and below window opening" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# West corridor wall windows (sill below + lintel above window at z=48-128)
for y in -900 -500 500 900; do
    # Sill (below window)
    wall -528 $((y-48)) 0 -512 $((y+48)) 48 "$T1" "$T1"
    # Lintel (above window)
    wall -528 $((y-48)) 128 -512 $((y+48)) 160 "$T1" "$T1"
    # East side
    wall 512 $((y-48)) 0 528 $((y+48)) 48 "$T1" "$T1"
    wall 512 $((y-48)) 128 528 $((y+48)) 160 "$T1" "$T1"
done

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// STAIRCASE IMPROVEMENTS — steps in outer rooms" >> "$OUT"
echo "// 3 steps leading up to elevated platforms" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# West outer south stairs (to platform at z=96)
for i in 0 1 2; do
    z=$((i*32))
    z2=$(((i+1)*32))
    x1=$((-1280 - i*32))
    x2=-1280
    box $x1 -1024 0 $x2 -768 $z2 "$F1"
done

# West outer north stairs
for i in 0 1 2; do
    z=$((i*32))
    z2=$(((i+1)*32))
    x1=$((-1280 - i*32))
    x2=-1280
    box $x1 768 0 $x2 1024 $z2 "$F1"
done

# East outer south stairs
for i in 0 1 2; do
    z=$((i*32))
    z2=$(((i+1)*32))
    x2=$((1280 + i*32))
    x1=1280
    box $x1 -1024 0 $x2 -768 $z2 "$F1"
done

# East outer north stairs
for i in 0 1 2; do
    z=$((i*32))
    z2=$(((i+1)*32))
    x2=$((1280 + i*32))
    x1=1280
    box $x1 768 0 $x2 1024 $z2 "$F1"
done

echo "" >> "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// NEON LIGHTING for new corridors" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# West side corridor neons (green theme)
for y in -1000 -500 0 500 1000; do
    neon_nx -1024 $((y-128)) 100 -1020 $((y+128)) 108 "urban_light/green_light_200"
done

# East side corridor neons (violet/red theme)
for y in -1000 -500 0 500 1000; do
    neon_px 1020 $((y-128)) 100 1024 $((y+128)) 108 "urban_light/red_light_200"
done

# Outer corridor neons
for y in -900 -400 400 900; do
    neon_nx -1536 $((y-96)) 100 -1532 $((y+96)) 108 "urban_light/blue_light_350"
    neon_px 1532 $((y-96)) 100 1536 $((y+96)) 108 "urban_light/blue_light_350"
done

# Connector tunnel neons
for y in -820 -220 244 844; do
    neon_px -1140 $y 120 -1136 $((y+40)) 128 "urban_light/green_light_200"
    neon_nx 1136 $y 120 1140 $((y+40)) 128 "urban_light/red_light_200"
done

COUNT=$(grep -c "^{" "$OUT")
echo "" >> "$OUT"
echo "// Total v39 brushes generated: $COUNT" >> "$OUT"
echo "Generated $COUNT brushes in $OUT"
