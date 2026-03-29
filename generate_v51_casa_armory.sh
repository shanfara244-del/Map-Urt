#!/bin/bash
# v51 — Rebuild Armory Room using EXACT Casa construction patterns
# 32u thick walls, caulk hidden faces, trim bands, windows, detailed props
# This replaces Zone 4 (West Wing) in the current map
OUT="v51_armory.txt"
> "$OUT"

# Casa-style brush: visible faces use textures, hidden use caulk
# Wall brush with exterior and interior textures
wall_ns() { # north-south wall (runs along Y axis)
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 tex_w=$7 tex_e=$8
    cat >> "$OUT" << EOF
{
( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) common/caulk 0 0 0 0.25 0.25 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) common/caulk 0 0 0 0.25 0.25 0 0 0
( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) $tex_w 0 0 0 0.5 0.5 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) $tex_e 0 0 0 0.5 0.5 0 0 0
( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) common/caulk 0 0 0 0.25 0.25 0 0 0
( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) common/caulk 0 0 0 0.25 0.25 0 0 0
}
EOF
}

wall_ew() { # east-west wall (runs along X axis)
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 tex_s=$7 tex_n=$8
    cat >> "$OUT" << EOF
{
( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) common/caulk 0 0 0 0.25 0.25 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) common/caulk 0 0 0 0.25 0.25 0 0 0
( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) common/caulk 0 0 0 0.25 0.25 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) common/caulk 0 0 0 0.25 0.25 0 0 0
( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) $tex_s 0 0 0 0.5 0.5 0 0 0
( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) $tex_n 0 0 0 0.5 0.5 0 0 0
}
EOF
}

floor_ceil() {
    local x1=$1 y1=$2 z1=$3 x2=$4 y2=$5 z2=$6 top_tex=$7
    cat >> "$OUT" << EOF
{
( $x1 $y2 $z1 ) ( $x1 $y1 $z1 ) ( $x2 $y1 $z1 ) common/caulk 0 0 0 0.25 0.25 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y1 $z2 ) ( $x1 $y1 $z2 ) $top_tex 0 0 0 0.5 0.5 0 0 0
( $x1 $y1 $z2 ) ( $x1 $y1 $z1 ) ( $x1 $y2 $z1 ) common/caulk 0 0 0 0.25 0.25 0 0 0
( $x2 $y2 $z2 ) ( $x2 $y2 $z1 ) ( $x2 $y1 $z1 ) common/caulk 0 0 0 0.25 0.25 0 0 0
( $x2 $y1 $z1 ) ( $x1 $y1 $z1 ) ( $x1 $y1 $z2 ) common/caulk 0 0 0 0.25 0.25 0 0 0
( $x2 $y2 $z2 ) ( $x1 $y2 $z2 ) ( $x1 $y2 $z1 ) common/caulk 0 0 0 0.25 0.25 0 0 0
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

# Textures — EvilLair unified
W="evil4_d_techwalls/d_tech_drkwall"        # primary wall
WP="evil4_d_techwalls/d_drkmtl_dpanel"      # accent wall
WS="evil4_d_techwalls/d_tech_drkwall_seam"   # seam variant
T="evil4_techtrims/dwtrim_panel"             # trim
TG="evil4_techtrims/dwtrim_grill"            # grill trim
F="evil4_techfloors/tfloor2"                 # floor
M="evil4_metals/drkmtl_default"              # metal detail
AC="tech1soc_wall/grill_wall03a"             # accent (crates)
AF="tech1soc_floor/block01a"                 # accent floor
C="common/caulk"

# Armory room bounds: (-1800,-400) to (-1200,400), z=0-192
# Using Casa pattern: 32u thick walls, trim at z=0-16 and z=176-192

echo "// v51 — ARMORY ROOM rebuilt with Casa construction patterns" >> "$OUT"
echo "// 32u thick walls, caulk hidden faces, integrated trim, windows" >> "$OUT"

# ============================================================
echo "" >> "$OUT"
echo "// === FLOOR (z=-8 to 0) ===" >> "$OUT"
floor_ceil -1800 -400 -8 -1200 400 0 "$F"

echo "" >> "$OUT"
echo "// === CEILING (z=192 to 200) ===" >> "$OUT"
floor_ceil -1800 -400 192 -1200 400 200 "$C"

echo "" >> "$OUT"
echo "// === WEST WALL (x=-1800 to -1768, full height) ===" >> "$OUT"
# Main wall body (z=16 to 176 — between trim bands)
wall_ns -1800 -400 16 -1768 400 176 "$C" "$W"
# Baseboard trim (z=0 to 16)
wall_ns -1800 -400 0 -1768 400 16 "$C" "$T"
# Crown trim (z=176 to 192)
wall_ns -1800 -400 176 -1768 400 192 "$C" "$T"

echo "" >> "$OUT"
echo "// === EAST WALL with doorway gap (x=-1232 to -1200) ===" >> "$OUT"
# South section (y=-400 to -80) — solid
wall_ns -1232 -400 16 -1200 -80 176 "$W" "$C"
wall_ns -1232 -400 0 -1200 -80 16 "$T" "$C"
wall_ns -1232 -400 176 -1200 -80 192 "$T" "$C"
# North section (y=80 to 400) — solid
wall_ns -1232 80 16 -1200 400 176 "$W" "$C"
wall_ns -1232 80 0 -1200 400 16 "$T" "$C"
wall_ns -1232 80 176 -1200 400 192 "$T" "$C"
# Lintel above doorway (y=-80 to 80, z=160 to 192)
wall_ns -1232 -80 160 -1200 80 192 "$W" "$C"

echo "" >> "$OUT"
echo "// === SOUTH WALL with doorway (y=-400 to -368) ===" >> "$OUT"
# West section (x=-1800 to -1500) — solid
wall_ew -1800 -400 16 -1500 -368 176 "$C" "$W"
wall_ew -1800 -400 0 -1500 -368 16 "$C" "$T"
wall_ew -1800 -400 176 -1500 -368 192 "$C" "$T"
# East section (x=-1300 to -1232) — solid
wall_ew -1300 -400 16 -1232 -368 176 "$C" "$W"
wall_ew -1300 -400 0 -1232 -368 16 "$C" "$T"
wall_ew -1300 -400 176 -1232 -368 192 "$C" "$T"
# Lintel above south doorway (x=-1500 to -1300, z=160 to 192)
wall_ew -1500 -400 160 -1300 -368 192 "$C" "$W"

echo "" >> "$OUT"
echo "// === NORTH WALL with doorway (y=368 to 400) ===" >> "$OUT"
wall_ew -1800 368 16 -1500 400 176 "$W" "$C"
wall_ew -1800 368 0 -1500 400 16 "$T" "$C"
wall_ew -1800 368 176 -1500 400 192 "$T" "$C"
wall_ew -1300 368 16 -1232 400 176 "$W" "$C"
wall_ew -1300 368 0 -1232 400 16 "$T" "$C"
wall_ew -1300 368 176 -1232 400 192 "$T" "$C"
wall_ew -1500 368 160 -1300 400 192 "$W" "$C"

echo "" >> "$OUT"
echo "// === WINDOW FRAMES in west wall (2 windows) ===" >> "$OUT"
# Window 1 (y=-250 to -150, z=48 to 144)
# Sill below window
wall_ns -1800 -258 32 -1768 -142 48 "$C" "$T"
# Lintel above window
wall_ns -1800 -258 144 -1768 -142 160 "$C" "$T"
# Left jamb
wall_ns -1800 -266 48 -1768 -258 144 "$C" "$T"
# Right jamb
wall_ns -1800 -142 48 -1768 -134 144 "$C" "$T"

# Window 2 (y=150 to 250, z=48 to 144)
wall_ns -1800 142 32 -1768 258 48 "$C" "$T"
wall_ns -1800 142 144 -1768 258 160 "$C" "$T"
wall_ns -1800 134 48 -1768 142 144 "$C" "$T"
wall_ns -1800 258 48 -1768 266 144 "$C" "$T"

echo "" >> "$OUT"
echo "// === BALCONY (z=128, north side) ===" >> "$OUT"
# Balcony floor
floor_ceil -1768 200 120 -1232 368 128 "$AF"
# Balcony railing
wall_ew -1768 196 128 -1232 200 168 "$T" "$M"
# Railing top bar
wall_ew -1768 196 164 -1232 204 168 "$M" "$M"

echo "" >> "$OUT"
echo "// === STAIRS to balcony (4 steps, z=0-128) ===" >> "$OUT"
floor_ceil -1768 100 0 -1700 200 32 "$AF"
floor_ceil -1768 132 32 -1732 200 64 "$AF"
floor_ceil -1768 164 64 -1764 200 96 "$AF"
floor_ceil -1768 180 96 -1768 200 128 "$AF"
# Stair side wall (trim)
wall_ns -1772 100 0 -1768 200 128 "$T" "$C"

echo "" >> "$OUT"
echo "// === PROPS: Weapon Racks (tall thin brushes against west wall) ===" >> "$OUT"
# Rack 1 (y=-350 to -250)
wall_ns -1772 -350 0 -1756 -250 128 "$C" "$WP"
# Rack shelf
floor_ceil -1772 -350 64 -1756 -250 68 "$M"
# Rack 2 (y=-100 to 0)
wall_ns -1772 -100 0 -1756 0 128 "$C" "$WP"
floor_ceil -1772 -100 64 -1756 0 68 "$M"
# Rack 3 (y=50 to 100)
wall_ns -1772 50 0 -1756 100 96 "$C" "$WP"
floor_ceil -1772 50 48 -1756 100 52 "$M"

echo "" >> "$OUT"
echo "// === PROPS: Central table ===" >> "$OUT"
# Table legs
floor_ceil -1560 -40 0 -1544 -24 28 "$M"
floor_ceil -1560 24 0 -1544 40 28 "$M"
floor_ceil -1440 -40 0 -1424 -24 28 "$M"
floor_ceil -1440 24 0 -1424 40 28 "$M"
# Table top
floor_ceil -1568 -48 28 -1416 48 32 "$AF"

echo "" >> "$OUT"
echo "// === PROPS: Supply crates (scattered) ===" >> "$OUT"
# Large crate
floor_ceil -1380 -320 0 -1316 -256 56 "$AC"
# Medium crate on top
floor_ceil -1368 -308 56 -1328 -268 80 "$AC"
# Small crate nearby
floor_ceil -1300 -360 0 -1260 -320 40 "$AC"
# Crate stack east side
floor_ceil -1280 200 0 -1240 264 48 "$AC"
floor_ceil -1272 212 48 -1248 252 72 "$AC"

echo "" >> "$OUT"
echo "// === NEON LIGHTING ===" >> "$OUT"
# West wall neon strip (z=160-168, inside room facing east)
neon -1772 -380 160 -1768 380 168 "urban_light/green_light_350"
# East wall neon (inside room facing west)
neon -1236 -380 160 -1232 -80 168 "urban_light/green_light_350"
neon -1236 80 160 -1232 380 168 "urban_light/green_light_350"
# Balcony neon (underside glow)
neon -1760 204 120 -1240 208 128 "urban_light/green_light_200"
# Floor accent
neon -1560 -4 0 -1420 4 4 "urban_light/green_light_100"

echo "" >> "$OUT"
echo "// === CEILING DETAILS ===" >> "$OUT"
# Ceiling beam 1
floor_ceil -1800 -8 184 -1200 8 192 "$M"
# Ceiling beam 2
floor_ceil -1508 -400 184 -1492 400 192 "$M"
# Recessed ceiling panel
floor_ceil -1700 -300 180 -1300 -100 184 "$WP"
floor_ceil -1700 100 180 -1300 300 184 "$WP"

echo "" >> "$OUT"
echo "// === FLOOR DETAILS ===" >> "$OUT"
# Floor trim around room perimeter (2u raised strip)
floor_ceil -1768 -368 0 -1232 -360 2 "$T"
floor_ceil -1768 360 0 -1232 368 2 "$T"
floor_ceil -1768 -360 0 -1760 360 2 "$T"
floor_ceil -1240 -360 0 -1232 360 2 "$T"
# Central floor grate
floor_ceil -1580 -60 0 -1400 60 2 "$F"

COUNT=$(grep -c "^{" "$OUT")
echo "" >> "$OUT"
echo "// v51 Armory total: $COUNT brushes (Casa-quality construction)" >> "$OUT"
echo "Generated $COUNT brushes for Armory room"
