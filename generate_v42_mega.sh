#!/bin/bash
# v42 MEGA — Trim + Props + Geometry (300+ brushes)
# ALL using unified EvilLair palette
OUT="v42_brushes.txt"
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

# Textures
W="evil4_d_techwalls/d_tech_drkwall"
WP="evil4_d_techwalls/d_drkmtl_dpanel"
WS="evil4_d_techwalls/d_tech_drkwall_seam"
T="evil4_techtrims/evil4_mtl_strp1"
F="evil4_techfloors/e4tflr_grt_01"
M="evil4_metals/evil4_mtl2"
AC="tech1soc_wall/grill_wall03a"
AF="tech1soc_floor/block01a"

echo "// v42 MEGA — Unified EvilLair trim + props + geometry" >> "$OUT"

# ============================================================
echo "" >> "$OUT"
echo "// === BASEBOARDS z=0-8 — every wall in corridor ===" >> "$OUT"
# Corridor baseboards (continuous strips)
box -512 -1280 0 -504 -512 8 "$T" "$T"
box -512 512 0 -504 1280 8 "$T" "$T"
box 504 -1280 0 512 -512 8 "$T" "$T"
box 504 512 0 512 1280 8 "$T" "$T"
# Flank baseboards
box -1024 -512 0 -1016 512 8 "$T" "$T"
box 1016 -512 0 1024 512 8 "$T" "$T"
# Outer wall baseboards
box -1536 -1280 0 -1528 1280 8 "$T" "$T"
box 1528 -1280 0 1536 1280 8 "$T" "$T"
# Base room baseboards
box -768 -2048 96 -760 -1664 104 "$T" "$T"
box 760 -2048 96 768 -1664 104 "$T" "$T"
box -768 1664 96 -760 2048 104 "$T" "$T"
box 760 1664 96 768 2048 104 "$T" "$T"

# ============================================================
echo "" >> "$OUT"
echo "// === CROWN MOLDING — top of every corridor wall ===" >> "$OUT"
box -512 -1280 184 -504 -512 192 "$T" "$T"
box -512 512 184 -504 1280 192 "$T" "$T"
box 504 -1280 184 512 -512 192 "$T" "$T"
box 504 512 184 512 1280 192 "$T" "$T"
# Flank crown
box -1024 -512 152 -1016 512 160 "$T" "$T"
box 1016 -512 152 1024 512 160 "$T" "$T"

# ============================================================
echo "" >> "$OUT"
echo "// === DOOR FRAME TRIM — every major opening ===" >> "$OUT"
# Corridor-to-flank openings (y=-512 and y=512)
for y in -516 508; do
    y2=$((y+8))
    # West side
    box -528 $y 0 -512 $y2 160 "$T" "$T"
    box -528 $y 152 -768 $y2 160 "$T" "$T"
    # East side
    box 512 $y 0 528 $y2 160 "$T" "$T"
    box 528 $y 152 768 $y2 160 "$T" "$T"
done
# Base entrance frames (existing front walls)
for y in -1684 -1676 1668 1676; do
    y2=$((y+8))
    box -132 $y 96 -128 $y2 240 "$T" "$T"
    box 128 $y 96 132 $y2 240 "$T" "$T"
    box -128 $y 232 128 $y2 240 "$T" "$T"
done
# Building entrance frames
for y in -292 -288 284 288; do
    y2=$((y+4))
    box -100 $y 8 -96 $y2 120 "$T" "$T"
    box 96 $y 8 100 $y2 120 "$T" "$T"
    box -96 $y 112 96 $y2 120 "$T" "$T"
done

# ============================================================
echo "" >> "$OUT"
echo "// === PIPE RUNS — ceiling pipes along corridors ===" >> "$OUT"
# Main corridor pipes (4 runs)
box -480 -1280 200 -472 1280 208 "$M" "$M"
box 472 -1280 200 480 1280 208 "$M" "$M"
box -300 -1280 216 -292 1280 224 "$M" "$M"
box 292 -1280 216 300 1280 224 "$M" "$M"
# Flank pipes
box -960 -512 144 -952 512 152 "$M" "$M"
box 952 -512 144 960 512 152 "$M" "$M"
# Cross pipes
box -512 -8 216 512 8 224 "$M" "$M"
box -512 -648 200 512 -640 208 "$M" "$M"
box -512 640 200 512 648 208 "$M" "$M"

# ============================================================
echo "" >> "$OUT"
echo "// === WALL PANELS — break up flat walls ===" >> "$OUT"
# Indented panels on corridor walls (every 256u)
for y in -1100 -850 -600 -350 -100 100 350 600 850 1100; do
    # West wall panel (indented 8u, 96u wide, z=32-160)
    box -520 $((y-48)) 32 -512 $((y+48)) 160 "$WP" "$WP"
    # East wall panel
    box 512 $((y-48)) 32 520 $((y+48)) 160 "$WP" "$WP"
done

# ============================================================
echo "" >> "$OUT"
echo "// === SUPPORT BRACKETS on walls ===" >> "$OUT"
# L-shaped brackets every 400u on corridor walls
for y in -1000 -600 -200 200 600 1000; do
    # West bracket (horizontal)
    box -520 $((y-8)) 128 -512 $((y+8)) 136 "$M" "$M"
    # West bracket (vertical)
    box -520 $((y-4)) 100 -516 $((y+4)) 128 "$M" "$M"
    # East bracket
    box 512 $((y-8)) 128 520 $((y+8)) 136 "$M" "$M"
    box 516 $((y-4)) 100 520 $((y+4)) 128 "$M" "$M"
done

# ============================================================
echo "" >> "$OUT"
echo "// === VENTILATION GRATES (ceiling mounted) ===" >> "$OUT"
# Dark rectangles on ceiling simulating vents
for y in -900 -300 300 900; do
    box -200 $((y-32)) 232 200 $((y+32)) 240 "$WS" "$WS"
done
# Flank vents
for y in -300 0 300; do
    box -960 $((y-24)) 152 -832 $((y+24)) 160 "$WS" "$WS"
    box 832 $((y-24)) 152 960 $((y+24)) 160 "$WS" "$WS"
done

# ============================================================
echo "" >> "$OUT"
echo "// === FLOOR TRANSITION STRIPS ===" >> "$OUT"
# Raised metal strips at zone boundaries
box -512 -1284 0 512 -1276 4 "$T" "$T"
box -512 1276 0 512 1284 4 "$T" "$T"
box -1028 -516 0 -1020 516 4 "$T" "$T"
box 1020 -516 0 1028 516 4 "$T" "$T"
# Base entrance floor strip
box -768 -1668 96 768 -1660 100 "$T" "$T"
box -768 1660 96 768 1668 100 "$T" "$T"

# ============================================================
echo "" >> "$OUT"
echo "// === FURNITURE: DESKS ===" >> "$OUT"
# 2 desks per command room = 8 desks total (3 brushes each = 24)
for sign in -1 1; do
    for xbase in -896 896; do
        yb=$((sign * 1720))
        # Desk top
        box $((xbase-64)) $((yb-32)) 32 $((xbase+64)) $((yb+32)) 40 "$AF" "$M"
        # Desk leg left
        box $((xbase-60)) $((yb-28)) 0 $((xbase-48)) $((yb-20)) 32 "$M" "$M"
        # Desk leg right
        box $((xbase+48)) $((yb-28)) 0 $((xbase+60)) $((yb-20)) 32 "$M" "$M"
    done
done

echo "" >> "$OUT"
echo "// === FURNITURE: WALL SHELVES ===" >> "$OUT"
# 2 shelves per command room = 8 (2 brushes each = 16)
for sign in -1 1; do
    for xbase in -896 896; do
        yb=$((sign * 1760))
        # Shelf bracket
        box $((xbase-40)) $((yb-4)) 80 $((xbase-32)) $((yb+4)) 96 "$M" "$M"
        # Shelf surface
        box $((xbase-40)) $((yb-4)) 96 $((xbase+40)) $((yb+4)) 100 "$AF" "$M"
    done
done

echo "" >> "$OUT"
echo "// === FURNITURE: SUPPLY CRATES in bases ===" >> "$OUT"
# 4 crate groups in bases (3 brushes each = 12)
for ybase in -1950 -1850; do
    # Red base west crate
    box -600 $((ybase-24)) 96 -552 $((ybase+24)) 144 "$AC" "$W"
    box -588 $((ybase-16)) 144 -564 $((ybase+16)) 168 "$AC" "$W"
done
for ybase in 1850 1950; do
    # Blue base east crate
    box 552 $((ybase-24)) 96 600 $((ybase+24)) 144 "$AC" "$W"
    box 564 $((ybase-16)) 144 588 $((ybase+16)) 168 "$AC" "$W"
done

echo "" >> "$OUT"
echo "// === FURNITURE: EQUIPMENT BOXES in alcoves ===" >> "$OUT"
for y in -1100 -700 -300 300 700 1100; do
    # Small box in west alcove
    box -548 $((y-16)) 0 -532 $((y+16)) 24 "$M" "$WP"
    # Small box in east alcove
    box 532 $((y-16)) 0 548 $((y+16)) 24 "$M" "$WP"
done

echo "" >> "$OUT"
echo "// === STAIR RAILINGS ===" >> "$OUT"
# Building west stairs railing
box -388 -68 0 -384 -64 136 "$M" "$M"
box -388 64 0 -384 68 136 "$M" "$M"
box -388 -68 128 -384 68 136 "$M" "$M"
# Building east stairs railing
box 384 -68 0 388 -64 136 "$M" "$M"
box 384 64 0 388 68 136 "$M" "$M"
box 384 -68 128 388 68 136 "$M" "$M"

echo "" >> "$OUT"
echo "// === CEILING BEAMS in outer rooms ===" >> "$OUT"
for y in -1000 -700 700 1000; do
    box -1536 $((y-8)) 160 -1024 $((y+8)) 168 "$M" "$M"
    box 1024 $((y-8)) 160 1536 $((y+8)) 168 "$M" "$M"
done

echo "" >> "$OUT"
echo "// === NEON ACCENT STRIPS for new areas ===" >> "$OUT"
# Command room floor neons
neon -1004 -1780 100 -1000 -1620 108 "urban_light/red_light_200"
neon 1000 -1780 100 1004 -1620 108 "urban_light/red_light_200"
neon -1004 1620 100 -1000 1780 108 "urban_light/blue_light_200"
neon 1000 1620 100 1004 1780 108 "urban_light/blue_light_200"
# Approach tunnel neons
neon -396 -1390 80 -392 -1290 88 "urban_light/red_light_350"
neon 392 -1390 80 396 -1290 88 "urban_light/red_light_350"
neon -396 1290 80 -392 1390 88 "urban_light/blue_light_350"
neon 392 1290 80 396 1390 88 "urban_light/blue_light_350"

COUNT=$(grep -c "^{" "$OUT")
echo "" >> "$OUT"
echo "// v42 total: $COUNT brushes" >> "$OUT"
echo "Generated $COUNT brushes"
