// ==========================================================
// ut4_neonduct — Neon surface light shaders
// Theme: industrial underground, cyan/violet/orange neons
// ==========================================================

// --- CYAN NEON STRIP ---
// Use on thin brush faces to create glowing cyan strips
textures/ut4_neonduct/neon_cyan
{
	qer_editorimage textures/common/white
	q3map_surfacelight 300
	q3map_lightRGB 0 0.9 1
	surfaceparm nomarks
	surfaceparm nolightmap
	{
		map $whiteimage
		rgbGen const ( 0 0.9 1 )
	}
}

// --- VIOLET NEON STRIP ---
textures/ut4_neonduct/neon_violet
{
	qer_editorimage textures/common/white
	q3map_surfacelight 250
	q3map_lightRGB 0.6 0 1
	surfaceparm nomarks
	surfaceparm nolightmap
	{
		map $whiteimage
		rgbGen const ( 0.6 0 1 )
	}
}

// --- ORANGE NEON STRIP ---
textures/ut4_neonduct/neon_orange
{
	qer_editorimage textures/common/white
	q3map_surfacelight 200
	q3map_lightRGB 1 0.4 0
	surfaceparm nomarks
	surfaceparm nolightmap
	{
		map $whiteimage
		rgbGen const ( 1 0.4 0 )
	}
}

// --- GREEN NEON (corridor markers) ---
textures/ut4_neonduct/neon_green
{
	qer_editorimage textures/common/white
	q3map_surfacelight 150
	q3map_lightRGB 0.2 1 0.3
	surfaceparm nomarks
	surfaceparm nolightmap
	{
		map $whiteimage
		rgbGen const ( 0.2 1 0.3 )
	}
}

// --- RED BASE GLOW (subtle team indicator) ---
textures/ut4_neonduct/glow_red
{
	qer_editorimage textures/common/white
	q3map_surfacelight 120
	q3map_lightRGB 1 0.15 0.1
	surfaceparm nomarks
	surfaceparm nolightmap
	{
		map $whiteimage
		rgbGen const ( 1 0.15 0.1 )
	}
}

// --- BLUE BASE GLOW (subtle team indicator) ---
textures/ut4_neonduct/glow_blue
{
	qer_editorimage textures/common/white
	q3map_surfacelight 120
	q3map_lightRGB 0.1 0.3 1
	surfaceparm nomarks
	surfaceparm nolightmap
	{
		map $whiteimage
		rgbGen const ( 0.1 0.3 1 )
	}
}

// --- WHITE CEILING LIGHT PANEL ---
textures/ut4_neonduct/light_panel
{
	qer_editorimage textures/common/white
	q3map_surfacelight 180
	q3map_lightRGB 1 0.95 0.85
	surfaceparm nomarks
	surfaceparm nolightmap
	{
		map $whiteimage
		rgbGen const ( 1 0.95 0.85 )
	}
}
