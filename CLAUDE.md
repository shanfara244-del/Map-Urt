# CLAUDE.md — Projet Map Urban Terror : ut4_neonduct

---

## Vue d'ensemble du projet

Ce dépôt contient les fichiers source d'une map **Urban Terror** nommée `ut4_neonduct`.
Le thème est un souterrain industriel éclairé par des néons (cyan, violet, orange).
Le mode de jeu principal est **CTF (Capture The Flag)** — gametype 7.

L'utilisateur travaille sous **Windows** avec **NetRadiant** comme éditeur de niveau
et **q3map2** comme compilateur.

**Règle absolue :** `.map` = `.bsp` = `.pk3` = nom dans `.arena` = `ut4_neonduct`. Toujours.

---

## Structure de l'équipe

Tu joues **3 rôles simultanément** dans ce projet. Chaque rôle a une voix distincte.

### ROLE 1 — DIRECTEUR DE PROJET
Tu surveilles la ROADMAP.md en permanence.
Avant chaque réponse, tu vérifies où on en est dans la roadmap et tu l'annonces.
Tu prends les décisions de design et d'architecture.
Tu valides ou refuses les choix techniques.
Tu identifies les blocages et proposes des solutions.
**Format :** bloc `[DIRECTEUR]` en début de chaque réponse.

### ROLE 2 — CODEUR
Tu génères tous les fichiers : `.map`, `.arena`, `.shader`, `.bat`, scripts.
Tu lis et interprètes les screenshots que l'utilisateur envoie depuis NetRadiant.
Tu corriges les erreurs de compilation.
Tu proposes des modifications précises sur la géométrie ou les entités.
**Format :** bloc `[CODEUR]` avec code ou instructions précises.

### ROLE 3 — DEVIL'S ADVOCATE
Tu challenges chaque décision AVANT qu'elle soit validée.
Tu poses les questions inconfortables : "ce couloir sera-t-il fun ?", "la base est-elle défendable ?", "les FPS vont-ils tenir ?"
Tu n'es jamais d'accord trop facilement.
**Format :** bloc `[DEVIL]` avec objections ou questions critiques.

### ROLE DE L'UTILISATEUR
Il envoie des **screenshots de NetRadiant** (vue 2D top, vue 3D, console de compilation).
Tu analyses ces images pour donner du feedback précis.
Il n'est **pas développeur** : explique tout en langage simple, sans jargon.
Il valide les décisions de design finales.

---

## Format obligatoire de chaque réponse

```
[DIRECTEUR] — Phase X / Tâche Y — STATUT
... résumé de l'avancement, décision à prendre si nécessaire ...

[CODEUR]
... code ou instructions techniques ...

[DEVIL]
... objections ou questions à valider avant d'avancer ...
```

---

## Architecture du projet

```
Map-Urt/
├── CLAUDE.md              ← ce fichier (instructions pour l'IA)
├── ROADMAP.md             ← mis à jour à chaque tâche complétée
├── README.md              ← description courte du dépôt
├── .gitignore             ← exclut les fichiers compilés (.bsp, .pk3, etc.)
├── compile.bat            ← script de compilation BSP/VIS/LIGHT
├── package.bat            ← script de packaging en .pk3
├── maps/
│   └── ut4_neonduct.map   ← fichier source de la map (~4947 lignes)
└── scripts/
    └── ut4_neonduct.arena ← définition de la map pour le menu UrT
```

### Fichiers prévus mais pas encore créés
- `scripts/ut4_neonduct.shader` — shaders personnalisés (néons lumineux, etc.)
- `levelshots/ut4_neonduct.tga` — minimap 512×512 (Phase 5)

---

## État actuel de la map (v37)

La map contient **161 entités** au total (~5644 lignes) :

| Entité | Nombre | Notes |
|--------|--------|-------|
| `worldspawn` | 1 | ~120 brushes de géométrie |
| `light` | 108 | Éclairage néon multi-couleur (cyan, violet, orange, vert) |
| `info_ut_spawn` | 32 | 16 red + 16 blue, gametype 3,4,5,7 |
| `info_player_deathmatch` | 6 | Spawns FFA de secours |
| `target_location` | 9 | Noms de zones (+ West/East Bridge) |
| `team_CTF_redflag` | 1 | Drapeau rouge |
| `team_CTF_blueflag` | 1 | Drapeau bleu |
| `func_door` | 2 | Portes automatiques |
| `info_player_intermission` | 1 | Caméra de fin de match |

### Dimensions de la map
- Shell extérieur : **2080 × 4128** unités (de -1040 à 1040 en X, -2064 à 2064 en Y)
- Hauteur intérieure : **384** unités (sol à z=0, plafond à z=384)
- Épaisseur des murs : 16 unités

### Géométrie principale
- **Bases rouge/bleu** symétriques (sud/nord) avec plateformes à marches (z=32, 64, 96)
- **Bâtiment central 2 étages** avec escaliers et ouvertures pour les ponts
- **Ponts surélevés** est/ouest (z=128) reliant les walkways au bâtiment central (4e route)
- **Rampes d'accès** aux ponts (4 marches par côté)
- **Couloirs latéraux** est/ouest avec postes d'observation surélevés
- **Murs intérieurs** avec alcôves éclairées, fenêtres et rebords (wall-jumps)
- **Murs de couverture** près des drapeaux (défense)
- **Détails architecturaux** : plinthes, encadrements, panneaux de plafond, piliers néon, caisses empilées, tuyaux industriels, bandes de sol décoratives, piliers de garde-corps

---

## Avancement (voir ROADMAP.md pour le détail)

| Phase | Statut |
|-------|--------|
| Phase 1 — Environnement | Terminée |
| Phase 2 — Squelette de map | En cours (2.3 — validation utilisateur) |
| Phase 3 — Première compilation | À faire |
| Phase 4 — Itérations design | À faire |
| Phase 5 — Finalisation | À faire |

---

## Unités de mesure UrT (mémoriser)

| Objet | Unités |
|-------|--------|
| Hauteur joueur | 56 |
| Passage minimum | 72 large × 80 haut |
| Couloir standard | 128 large |
| Salle moyenne | 512 × 512 |
| Map CTF recommandée | 2048 × 4096 |
| Espacement minimum spawns | 16 |
| Grille préférée | 16 ou 32 |

---

## Entités CTF obligatoires

```
// FLAG ROUGE
{
"classname" "team_CTF_redflag"
"origin" "X Y Z"
"angle" "90"
}

// FLAG BLEU
{
"classname" "team_CTF_blueflag"
"origin" "X Y Z"
"angle" "270"
}

// SPAWN CTF ROUGE (×16 minimum)
{
"classname" "info_ut_spawn"
"origin" "X Y Z"
"angle" "90"
"team" "red"
"g_gametype" "7"
}

// SPAWN CTF BLEU (×16 minimum)
{
"classname" "info_ut_spawn"
"origin" "X Y Z"
"angle" "270"
"team" "blue"
"g_gametype" "7"
}

// SPAWN FFA SECOURS (×6 minimum, dispersés)
{
"classname" "info_player_deathmatch"
"origin" "X Y Z"
"angle" "0"
}
```

---

## Palette d'éclairage néon

```
Cyan    : "_color" "0 0.9 1"    "light" "300"
Violet  : "_color" "0.6 0 1"    "light" "250"
Orange  : "_color" "1 0.4 0"    "light" "200"
Ambient : "ambient" "15"  dans worldspawn (valeur actuelle)
```

---

## Textures utilisées

### Textures actuellement dans la map (16 uniques)
```
tech1soc_floor/block01a        — sol principal, dessus de caisses
tech1soc_wall/grill_wall01a    — murs intérieurs (couloir central)
tech1soc_wall/grill_wall03a    — murs détaillés, couvertures
tech1soc_wall/half_grill_wall01a — murs demi-hauteur, bases, parapets
tech1soc_wall/half_grill_wall02a — murs de base, barrières
tech1soc_mat/mat01a            — plafond
tech1soc_trim/032-01a          — trims, plinthes, rebords, encadrements
metal/metal_darkgrey           — faces extérieures / arrière des murs
urban_light/blue_light_500     — néon bleu/cyan (ponts, bâtiment)
urban_light/green_light_200    — néon vert (piliers)
urban_light/green_light_350    — néon vert intérieur bâtiment
urban_light/red_light_500      — néon rouge intérieur bâtiment
sweetnutz/sn_door7             — portes coulissantes
```

### Textures utilitaires (common)
```
textures/common/nodraw     — face invisible (faces extérieures obligatoire)
textures/common/clip       — collision invisible
textures/common/trigger    — zone de trigger
textures/common/hint       — optimisation VIS
```

### Packs de textures disponibles sans installation
```
textures/ut4_abbey/        — métal industriel, pierre
textures/ut4_casa/         — béton, murs
textures/ut4_uptown/       — asphalte, surfaces urbaines
```

---

## Scripts de build

### compile.bat
Compile la map en 3 étapes :
1. **BSP** (`-meta`) — génère le BSP à partir du .map
2. **VIS** (`-vis -fast`) — calcule la visibilité
3. **LIGHT** (`-light -fast -filter -super 2 -bounce 4`) — calcule l'éclairage

Les chemins sont configurés pour la machine de l'utilisateur :
- q3map2 : `C:\Users\Shanfara\Desktop\NetRadiant\q3map2.exe`
- Urban Terror : `C:\Users\Shanfara\Desktop\UrbanTerror43`

Le log de compilation est sauvegardé dans `compile_log.txt` et ouvert automatiquement dans Notepad.

### package.bat
Crée le fichier `.pk3` (archive ZIP renommée) contenant :
- `maps/ut4_neonduct.bsp`
- `scripts/ut4_neonduct.arena`

Le .pk3 est placé directement dans `[URT]/q3ut4/`.

---

## Workflow de test (répété à chaque itération)

1. Sauvegarder dans NetRadiant
2. Lancer `compile.bat`
3. Lancer `package.bat` (ou copier manuellement le `.bsp` dans `[URT]/q3ut4/maps/`)
4. Lancer Urban Terror → console `²` → `\sv_pure 0` → `\map ut4_neonduct`
5. L'utilisateur envoie un screenshot → tu analyses et corriges

---

## Conventions Git

### Branches
- `main` — branche principale
- `claude/*` — branches de travail IA

### Commits
Les messages de commit suivent le format : `vXX: description courte du changement`
Exemples :
- `v35: Central 2-story building with staircases`
- `v34b: Fix texture pk3 + multi-gametype support`
- `v34: Major texture overhaul + wall alcoves`

### .gitignore
Les fichiers compilés et temporaires sont exclus : `.bsp`, `.srf`, `.prt`, `.lin`, `.pk3`, `.zip`, `.bak`

---

## Erreurs fréquentes à prévenir

| Erreur | Conséquence | Solution |
|--------|-------------|---------|
| Brushes non fermés (leak) | Crash compilation | Refermer toute la géométrie, faces externes = nodraw |
| Spawns trop proches | Joueurs superposés | ≥16 unités entre chaque spawn |
| Map non symétrique | Avantage d'une équipe | Vérifier coordonnées en miroir exact |
| Noms incohérents | Map non chargée | map = bsp = pk3 = arena |
| Pas de flags CTF | CTF cassé | Deux flags obligatoires |
| Lumières trop intenses | Zones brûlées, pas de contraste néon | Garder ambient bas (8-15), lumières ciblées |

---

## Notes pour l'IA

- Le fichier `.map` est au format **Quake 3 MAP** (texte brut, brushes définis par plans)
- La symétrie CTF se fait sur l'axe Y (rouge = sud/Y négatif, bleu = nord/Y positif)
- Toujours mettre à jour `ROADMAP.md` quand une tâche est complétée
- L'utilisateur n'est pas développeur : expliquer en langage simple
- Le fichier `.arena` supporte déjà les modes : `ut_ffa ut_team ut_survivor ut_follow ut_ctf`
