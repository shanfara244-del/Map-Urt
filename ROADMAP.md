# ROADMAP — ut4_neonduct

> Ce fichier est mis à jour à chaque tâche complétée.
> Le Directeur de projet le lit en début de chaque réponse.

---

## Légende
- `[ ]` À faire
- `[→]` En cours
- `[✓]` Terminé
- `[!]` Bloqué — attente utilisateur

---

## PHASE 1 — Mise en place de l'environnement
`[✓]` **1.1** Localiser Urban Terror (chemin URT_PATH + q3ut4) — `C:\Users\Shanfara\Desktop\UrbanTerror43\`
`[✓]` **1.2** Localiser NetRadiant et q3map2.exe — `C:\Users\Shanfara\Desktop\NetRadiant\`
`[✓]` **1.3** Créer la structure de dossiers du projet — `Map-Urt/maps, scripts`
`[✓]` **1.4** Remplir compile.bat avec les vrais chemins
`[✓]` **1.5** Créer package.bat pour le packaging en .pk3
`[✓]` **1.6** Vérifier que NetRadiant reconnaît Urban Terror comme jeu — confirmé par l'utilisateur

---

## PHASE 2 — Squelette de map (layout de base)
`[✓]` **2.1** Générer `maps/ut4_neonduct.map` (worldspawn + shell extérieur)
`[✓]` **2.2** Générer `scripts/ut4_neonduct.arena`
`[✓]` **2.3** Bases rouge/bleu symétriques avec plateformes à marches (z=32, 64, 96)
`[✓]` **2.4** 4 piliers centraux (128×128, hauteur 192)
`[✓]` **2.5** Passerelles latérales est/ouest (z=64) avec escaliers d'accès
`[✓]` **2.6** Murs de base (encadrement des salles de flag)
`[✓]` **2.7** Blocs de couverture au centre + garde-corps des passerelles
`[✓]` **2.8** Murs intérieurs avec alcôves éclairées par des néons
`[✓]` **2.9** Bâtiment central 2 étages avec escaliers
`[✓]` **2.10** Détails architecturaux : plinthes, encadrements, panneaux de plafond, piliers néon, caisses
`[✓]` **2.11** Entités : 32 spawns CTF + 6 FFA + 2 flags + 7 target_locations + 2 func_doors + 92 lights
`[→]` **2.12** L'utilisateur ouvre la map dans NetRadiant → screenshot → validation

---

## PHASE 3 — Première compilation et test en jeu
`[ ]` **3.1** Lancer compile.bat → vérifier zéro erreur de leak
`[ ]` **3.2** Corriger les leaks éventuels (faces nodraw manquantes, brushes non fermés)
`[ ]` **3.3** Copier le BSP dans UrT → lancer le jeu → `\sv_pure 0` → `\map ut4_neonduct`
`[ ]` **3.4** Screenshot en jeu → valider que les lumières néon, flags et spawns fonctionnent
`[ ]` **3.5** Vérifier que les 2 portes func_door s'ouvrent correctement

---

## PHASE 4 — Gameplay et routes stratégiques
> Objectif : rendre la map compétitivement jouable avec des routes intéressantes.

### 4A — Validation du layout
`[ ]` **4A.1** Parcourir les 3 routes base-à-base (centre, est, ouest) et mesurer les temps de traversée
`[ ]` **4A.2** Vérifier que chaque route a des points de couverture et de danger équilibrés
`[ ]` **4A.3** S'assurer qu'aucune route n'est nettement supérieure aux autres
`[ ]` **4A.4** Valider les lignes de tir (sightlines) : pas de snipe direct base-à-base

### 4B — Verticalité et complexité
`[ ]` **4B.1** Ajouter des passages secondaires (tunnels souterrains ou conduits au plafond)
`[ ]` **4B.2** Créer des sauts ou raccourcis pour joueurs expérimentés
`[ ]` **4B.3** Ajouter des rebords/corniches sur les murs pour les wall-jumps
`[ ]` **4B.4** Balcon ou mezzanine dans la zone centrale (vue plongeante contrôlable)

### 4C — Bases et flag rooms
`[ ]` **4C.1** Ajouter une salle arrière / backroom derrière chaque flag (voie d'évasion)
`[ ]` **4C.2** Ajouter des brushes de couverture dans la flag room (caisse, muret)
`[ ]` **4C.3** Ventilation ou ouverture au plafond de la flag room (entrée alternative)
`[ ]` **4C.4** Tester la défendabilité : 1 défenseur doit pouvoir retarder 2 attaquants

---

## PHASE 5 — Éclairage et ambiance
> Objectif : passer d'un éclairage fonctionnel à une atmosphère cinématique.

### 5A — Rework éclairage existant
`[ ]` **5A.1** Réduire le nombre de lights redondantes (actuellement 92 — viser ~60-70 optimisées)
`[ ]` **5A.2** Ajouter des zones sombres intentionnelles (embuscades, tension)
`[ ]` **5A.3** Différencier l'ambiance par zone : cyan dominant au centre, violet dans les couloirs, orange aux bases
`[ ]` **5A.4** Ajouter un dégradé de lumière pour les transitions entre zones

### 5B — Shaders et effets
`[ ]` **5B.1** Créer `scripts/ut4_neonduct.shader` — néons lumineux (surfacelight)
`[ ]` **5B.2** Shader de néon pulsant (animation subtile q3map_surfacelight)
`[ ]` **5B.3** Shader de sol mouillé/réflectif dans les couloirs
`[ ]` **5B.4** Fog léger dans certaines zones pour la profondeur

### 5C — Détails visuels
`[ ]` **5C.1** Tuyaux et conduits décoratifs le long des plafonds
`[ ]` **5C.2** Grilles au sol avec lumière en dessous
`[ ]` **5C.3** Panneaux muraux / signalétique industrielle
`[ ]` **5C.4** Débris et détails au sol (ne pas bloquer la navigation)

---

## PHASE 6 — Optimisation et performance
> Objectif : s'assurer que le jeu tourne à 60+ FPS en toutes circonstances.

`[ ]` **6.1** Ajouter des hint brushes aux jonctions critiques (couloirs → zone centrale)
`[ ]` **6.2** Vérifier le VIS avec `-vis` (pas `-vis -fast`) pour un découpage optimal
`[ ]` **6.3** Remplacer les faces non visibles par `nodraw`
`[ ]` **6.4** Compiler en `-light` final (sans `-fast`) : `-light -filter -super 2 -bounce 8`
`[ ]` **6.5** Tester les FPS en jeu dans chaque zone, noter les zones problématiques
`[ ]` **6.6** Ajouter des area portals aux portes si nécessaire

---

## PHASE 7 — Son et ambiance audio
> Objectif : couche sonore immersive.

`[ ]` **7.1** Identifier les sons d'ambiance disponibles dans UrT (bourdonnement, eau, vent)
`[ ]` **7.2** Placer des `target_speaker` pour l'ambiance industrielle (bourdonnement électrique)
`[ ]` **7.3** Sons d'eau / gouttes dans les zones basses
`[ ]` **7.4** Son de vent / ventilation dans les conduits

---

## PHASE 8 — Polish et finalisation
> Objectif : map prête pour la distribution.

### 8A — Clip et collision
`[ ]` **8A.1** Ajouter des clip brushes sur tous les rebords décoratifs qui accrochent le joueur
`[ ]` **8A.2** Clip les piliers et colonnes pour un mouvement fluide
`[ ]` **8A.3** Clip les marches d'escalier (rampe invisible) pour un déplacement lisse
`[ ]` **8A.4** Vérifier qu'aucun joueur ne peut sortir de la map (stuck spots, sky exploits)

### 8B — Textures et cohérence visuelle
`[ ]` **8B.1** Audit de toutes les textures : alignement, échelle, absence de stretching
`[ ]` **8B.2** Varier les textures murales (actuellement tout en grill_wall01a)
`[ ]` **8B.3** Textures distinctes pour les zones de chaque équipe (tons chauds rouge, tons froids bleu)
`[ ]` **8B.4** Textures de sol différenciées par zone (base, couloir, centre)

### 8C — Entités et finitions
`[ ]` **8C.1** Vérifier et ajuster les 7 target_locations (noms de zones en jeu)
`[ ]` **8C.2** Ajouter des `info_player_intermission` supplémentaires (caméras de fin de match)
`[ ]` **8C.3** Vérifier l'angle de tous les spawns (face à l'action, pas face au mur)
`[ ]` **8C.4** Créer `levelshots/ut4_neonduct.tga` — minimap 512×512

---

## PHASE 9 — Tests et itérations
> Objectif : boucle de playtest jusqu'à satisfaction.

`[ ]` **9.1** Test solo : parcourir chaque route, chronométrer flag-à-flag
`[ ]` **9.2** Test avec bots (si possible) : observer le comportement IA
`[ ]` **9.3** Vérifier la symétrie parfaite (comparer coordonnées miroir Y)
`[ ]` **9.4** Compilations de validation : `-meta`, `-vis`, `-light` sans `-fast`
`[ ]` **9.5** Itérer : chaque screenshot utilisateur → analyse → correction → recompile

---

## PHASE 10 — Packaging et release
`[ ]` **10.1** Compilation finale (qualité maximale, sans -fast)
`[ ]` **10.2** Packaging en `.pk3` avec tous les assets : BSP, arena, shader, levelshot
`[ ]` **10.3** Test du .pk3 final : installation propre dans UrT → jouer une partie complète
`[ ]` **10.4** Vérification de la checklist finale (voir ci-dessous)

---

## Checklist de validation finale (Phase 10)

- [ ] Map rigoureusement symétrique (axe Y)
- [ ] 2 flags CTF présents et accessibles
- [ ] 16+ spawns rouge + 16+ spawns bleu (gametype 7)
- [ ] 6+ spawns FFA dispersés
- [ ] Compilation sans erreur (zéro leak)
- [ ] FPS >60 dans toutes les zones
- [ ] 3 routes distinctes base-à-base
- [ ] Bases défendables mais pas imprenables
- [ ] Éclairage néon thématique et cohérent
- [ ] Clip brushes sur tous les éléments décoratifs
- [ ] Aucun stuck spot ou exploit
- [ ] Fichier .shader fonctionnel
- [ ] Levelshot TGA 512×512 présent
- [ ] Fichier .arena correct et complet
- [ ] Nom cohérent partout (ut4_neonduct)
- [ ] .pk3 testé et fonctionnel
- [ ] Sons d'ambiance en place

---

## Journal des décisions
*Les grandes décisions de design sont notées ici avec la date.*

- **[init]** Thème : souterrain industriel néon
- **[init]** Mode : CTF (gametype 7) + support FFA/Team/Survivor/Follow
- **[init]** Palette néon : cyan principal, violet secondaire, orange accent
- **[v31]** Surface lights pour les néons
- **[v32]** Ajout de détails architecturaux (plinthes, encadrements, piliers néon, caisses)
- **[v33]** Alcôves murales avec néons encastrés
- **[v34]** Refonte des textures + support multi-gametype dans .arena
- **[v35]** Bâtiment central 2 étages avec escaliers
- **[v37]** Route surélevée (ponts E-W + rampes + ouvertures bâtiment)
- **[v37]** Cover défensif près des drapeaux, caisses tactiques, postes d'observation
- **[v37]** Détails architecturaux : tuyaux, bandes sol, rebords fenêtres, piliers garde-corps
- **[v38]** Tunnel souterrain (5e route), arches de couloir, consoles murales, poutres
- **[v39]** Balcons mezzanine, barricades bases, caps piliers, néons équipe, ventilation
- **[v40-v44]** Side rooms, sniper perches, coffered ceiling, approach forts, walkway upper level, pipe network, base interior expansion, floor patterns, wall sconces, buttresses, back wall panels, pilasters, ceiling light panels, drainage channels, stanchions
- **[v45-v49]** Wall niches, overhead catwalk, connector passages, outer wall windows, building interior furnishing, baseboards, crown molding, scattered crates, pipe elbows, team floor markers, ceiling fan housings, bollards

---

## Priorités immédiates (prochaines actions)

1. **Valider le layout actuel** — L'utilisateur doit ouvrir la map dans NetRadiant et envoyer un screenshot (tâche 2.12)
2. **Première compilation** — Tester que la map compile sans leak (Phase 3)
3. **Gameplay** — Ajouter des routes secondaires et de la verticalité (Phase 4)
