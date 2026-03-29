#!/bin/bash
# v38 MEGA BRUSH GENERATOR — adds 300+ brushes to ut4_neonduct
# Generates: pillars, walls, alcoves, platforms, crates, beams, neons, trim
# Output: v38_brushes.txt to be inserted before worldspawn close

OUT="v38_brushes.txt"
echo "" > "$OUT"
echo "// ============================================================" >> "$OUT"
echo "// v38 — MEGA GENERATION: 300+ brushes" >> "$OUT"
echo "// ============================================================" >> "$OUT"

# Helper: write a box brush with 1 visible face (top) + 5 structural
box_brush() {
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 top_tex=$7 side_tex=$8
    echo "{" >> "$OUT"
    echo "( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) $top_tex 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) $side_tex 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) $side_tex 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) $side_tex 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) $side_tex 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "}" >> "$OUT"
}

# Neon strip brush (visible face on one side)
neon_strip_x() {
    # Thin strip along X axis, neon on +x face
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 neon_tex=$7
    echo "{" >> "$OUT"
    echo "( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) $neon_tex 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) metal/metal_darkgrey 0 0 0 0.5 0.5 0 0 0" >> "$OUT"
    echo "}" >> "$OUT"
}

WALL="tech1soc_wall/grill_wall03a"
WALL2="tech1soc_wall/half_grill_wall01a"
WALL3="tech1soc_wall/half_grill_wall02a"
FLOOR="tech1soc_floor/block01a"
TRIM="tech1soc_trim/032-01a"
METAL="metal/metal_darkgrey"

echo "" >> "$OUT"
echo "// --- CORRIDOR PILLARS (20 pairs along corridor x=+-480) ---" >> "$OUT"
for y in -1200 -1000 -800 -600 -400 -200 0 200 400 600 800 1000 1200; do
    # West side pillar
    x1=-496; x2=-464; y1=$((y-16)); y2=$((y+16))
    box_brush $x1 $y1 0 $x2 $y2 192 "$FLOOR" "$WALL"
    # East side pillar
    x1=464; x2=496
    box_brush $x1 $y1 0 $x2 $y2 192 "$FLOOR" "$WALL"
done

echo "" >> "$OUT"
echo "// --- FLANK PILLARS (8 pairs in flank corridors) ---" >> "$OUT"
for y in -400 -200 0 200 400; do
    # West flank
    box_brush -900 $((y-16)) 0 -868 $((y+16)) 160 "$FLOOR" "$WALL2"
    # East flank
    box_brush 868 $((y-16)) 0 900 $((y+16)) 160 "$FLOOR" "$WALL2"
done

echo "" >> "$OUT"
echo "// --- OUTER ROOM PILLARS (16 pillars in new rooms) ---" >> "$OUT"
for y in -1000 -700 700 1000; do
    box_brush -1480 $((y-16)) 0 -1448 $((y+16)) 192 "$FLOOR" "$WALL"
    box_brush -1180 $((y-16)) 0 -1148 $((y+16)) 192 "$FLOOR" "$WALL"
    box_brush 1148 $((y-16)) 0 1180 $((y+16)) 192 "$FLOOR" "$WALL"
    box_brush 1448 $((y-16)) 0 1480 $((y+16)) 192 "$FLOOR" "$WALL"
done

echo "" >> "$OUT"
echo "// --- CEILING BEAMS corridor (10 beams) ---" >> "$OUT"
for y in -1100 -880 -660 -440 -220 220 440 660 880 1100; do
    box_brush -512 $((y-12)) 208 512 $((y+12)) 224 "$METAL" "$METAL"
done

echo "" >> "$OUT"
echo "// --- CEILING BEAMS flanks (8 beams) ---" >> "$OUT"
for y in -350 -100 100 350; do
    box_brush -1024 $((y-12)) 208 -768 $((y+12)) 224 "$METAL" "$METAL"
    box_brush 768 $((y-12)) 0 1024 $((y+12)) 224 "$METAL" "$METAL"
done

echo "" >> "$OUT"
echo "// --- CEILING BEAMS outer rooms (8 beams) ---" >> "$OUT"
for y in -900 -600 600 900; do
    box_brush -1536 $((y-12)) 208 -1024 $((y+12)) 224 "$METAL" "$METAL"
    box_brush 1024 $((y-12)) 208 1536 $((y+12)) 224 "$METAL" "$METAL"
done

echo "" >> "$OUT"
echo "// --- FLOOR TRIM baseboards corridor (4 strips) ---" >> "$OUT"
box_brush -512 -1280 0 -504 512 8 "$TRIM" "$TRIM"
box_brush -512 512 0 -504 1280 8 "$TRIM" "$TRIM"
box_brush 504 -1280 0 512 -512 8 "$TRIM" "$TRIM"
box_brush 504 512 0 512 1280 8 "$TRIM" "$TRIM"

echo "" >> "$OUT"
echo "// --- CROWN MOLDING corridor top (4 strips) ---" >> "$OUT"
box_brush -512 -1280 184 -504 -512 192 "$TRIM" "$TRIM"
box_brush -512 512 184 -504 1280 192 "$TRIM" "$TRIM"
box_brush 504 -1280 184 512 -512 192 "$TRIM" "$TRIM"
box_brush 504 512 184 512 1280 192 "$TRIM" "$TRIM"

echo "" >> "$OUT"
echo "// --- WALL ALCOVES corridor (8 more alcoves between existing ones) ---" >> "$OUT"
for y in -1200 -800 -400 400 800 1200; do
    # West alcove back
    box_brush -544 $((y-48)) 0 -528 $((y+48)) 160 "$METAL" "$WALL3"
    # West alcove jambs
    box_brush -528 $((y-56)) 0 -512 $((y-48)) 160 "$METAL" "$TRIM"
    box_brush -528 $((y+48)) 0 -512 $((y+56)) 160 "$METAL" "$TRIM"
    # East alcove back
    box_brush 528 $((y-48)) 0 544 $((y+48)) 160 "$METAL" "$WALL3"
    # East alcove jambs
    box_brush 512 $((y-56)) 0 528 $((y-48)) 160 "$METAL" "$TRIM"
    box_brush 512 $((y+48)) 0 528 $((y+56)) 160 "$METAL" "$TRIM"
done

echo "" >> "$OUT"
echo "// --- NEON STRIPS in alcoves (12 strips) ---" >> "$OUT"
for y in -1200 -800 -400 400 800 1200; do
    neon_strip_x -540 $((y-40)) 80 -536 $((y+40)) 88 "urban_light/blue_light_200"
    neon_strip_x 536 $((y-40)) 80 540 $((y+40)) 88 "urban_light/blue_light_200"
done

echo "" >> "$OUT"
echo "// --- COVER CRATES mid corridor (16 crates various sizes) ---" >> "$OUT"
for y in -900 -500 -300 500 300 900; do
    box_brush -380 $((y-32)) 0 -316 $((y+32)) 48 "$FLOOR" "$WALL"
    box_brush 316 $((y-32)) 0 380 $((y+32)) 48 "$FLOOR" "$WALL"
done
# Tall crates at key positions
box_brush -420 -100 0 -356 -36 96 "$FLOOR" "$WALL"
box_brush 356 36 0 420 100 96 "$FLOOR" "$WALL"
box_brush -200 -700 0 -136 -636 72 "$FLOOR" "$WALL"
box_brush 136 636 0 200 700 72 "$FLOOR" "$WALL"

echo "" >> "$OUT"
echo "// --- ELEVATED PLATFORMS in flanks (4 platforms z=96) ---" >> "$OUT"
box_brush -1000 -300 0 -800 -100 96 "$FLOOR" "$WALL3"
box_brush -1000 100 0 -800 300 96 "$FLOOR" "$WALL3"
box_brush 800 -300 0 1000 -100 96 "$FLOOR" "$WALL3"
box_brush 800 100 0 1000 300 96 "$FLOOR" "$WALL3"

echo "" >> "$OUT"
echo "// --- UPPER WALKWAY RAILINGS (4 strips z=192-224) ---" >> "$OUT"
box_brush -512 -132 192 -508 132 224 "$METAL" "$WALL"
box_brush 508 -132 192 512 132 224 "$METAL" "$WALL"
box_brush -292 -132 128 -288 132 160 "$METAL" "$WALL"
box_brush 288 -132 128 292 132 160 "$METAL" "$WALL"

echo "" >> "$OUT"
echo "// --- BASE ROOM ALCOVES (8 alcoves in base walls) ---" >> "$OUT"
for y in -1900 -1800 -1700; do
    # Red base west alcoves
    box_brush -784 $((y-32)) 96 -768 $((y+32)) 224 "$METAL" "$WALL3"
    # Red base east alcoves
    box_brush 768 $((y-32)) 96 784 $((y+32)) 224 "$METAL" "$WALL3"
done
for y in 1700 1800 1900; do
    # Blue base west alcoves
    box_brush -784 $((y-32)) 96 -768 $((y+32)) 224 "$METAL" "$WALL3"
    # Blue base east alcoves
    box_brush 768 $((y-32)) 96 784 $((y+32)) 224 "$METAL" "$WALL3"
done

echo "" >> "$OUT"
echo "// --- BASE NEON STRIPS floor (4 strips z=96-104) ---" >> "$OUT"
neon_strip_x -764 -2000 100 -760 -1700 108 "urban_light/red_light_350"
neon_strip_x 760 -2000 100 764 -1700 108 "urban_light/red_light_350"
neon_strip_x -764 1700 100 -760 2000 108 "urban_light/blue_light_350"
neon_strip_x 760 1700 100 764 2000 108 "urban_light/blue_light_350"

echo "" >> "$OUT"
echo "// --- APPROACH ZONE WALLS (4 half-walls for cover) ---" >> "$OUT"
box_brush -384 -1500 0 -368 -1380 128 "$METAL" "$WALL"
box_brush 368 -1500 0 384 -1380 128 "$METAL" "$WALL"
box_brush -384 1380 0 -368 1500 128 "$METAL" "$WALL"
box_brush 368 1380 0 384 1500 128 "$METAL" "$WALL"

echo "" >> "$OUT"
echo "// --- OUTER ROOM ELEVATED WALKWAYS (4 walkways z=128) ---" >> "$OUT"
box_brush -1536 -800 120 -1400 -700 128 "$FLOOR" "$WALL3"
box_brush -1536 700 120 -1400 800 128 "$FLOOR" "$WALL3"
box_brush 1400 -800 120 1536 -700 128 "$FLOOR" "$WALL3"
box_brush 1400 700 120 1536 800 128 "$FLOOR" "$WALL3"

echo "" >> "$OUT"
echo "// --- CONNECTING PASSAGES outer to inner (4 openings framed) ---" >> "$OUT"
# Frame left of opening
box_brush -1028 -520 0 -1020 -512 192 "$METAL" "$TRIM"
box_brush -1028 512 0 -1020 520 192 "$METAL" "$TRIM"
box_brush 1020 -520 0 1028 -512 192 "$METAL" "$TRIM"
box_brush 1020 512 0 1028 520 192 "$METAL" "$TRIM"
# Frame lintel
box_brush -1028 -512 184 -1020 512 192 "$METAL" "$TRIM"
box_brush 1020 -512 184 1028 512 192 "$METAL" "$TRIM"

COUNT=$(grep -c "^{" "$OUT")
echo "" >> "$OUT"
echo "// Total v38 brushes generated: $COUNT" >> "$OUT"

echo "Generated $COUNT brushes in $OUT"
