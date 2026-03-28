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
`[✓]` **1.3** Créer la structure de dossiers du projet — `urt_map_project/maps, scripts, levelshots`
`[✓]` **1.4** Remplir compile.bat avec les vrais chemins
`[✓]` **1.5** Vérifier que NetRadiant reconnaît Urban Terror comme jeu — confirmé par l'utilisateur

---

## PHASE 2 — Création du squelette de map
`[✓]` **2.1** Générer `maps/ut4_neonduct.map` (worldspawn + géométrie de base + entités)
`[✓]` **2.2** Générer `scripts/ut4_neonduct.arena`
`[→]` **2.3** L'utilisateur ouvre la map dans NetRadiant → screenshot → validation

---

## PHASE 3 — Première compilation et test
`[ ]` **3.1** Lancer compile.bat → vérifier zéro erreur de leak
`[ ]` **3.2** Copier le BSP dans UrT → tester en jeu
`[ ]` **3.3** Screenshot depuis UrT → valider lumières néon + flags + spawns

---

## PHASE 4 — Itérations de design (boucle)
*Cette phase se répète autant de fois que nécessaire.*
`[ ]` **4.x** L'utilisateur envoie screenshot → Directeur analyse → Codeur corrige → recompile

Points à valider avant de clore cette phase :
- Layout symétrique confirmé
- 3 routes entre les bases (haut / milieu / bas)
- Bases défendables mais pas imprenables
- Éclairage néon cohérent avec le thème
- FPS acceptable (testé en jeu)

---

## PHASE 5 — Finalisation
`[ ]` **5.1** Levelshot (minimap 512×512 TGA)
`[ ]` **5.2** Checklist de validation finale
`[ ]` **5.3** Packaging en `.pk3`
`[ ]` **5.4** Test du .pk3 final dans UrT

---

## Checklist de validation finale (Phase 5)
- [ ] Map rigoureusement symétrique
- [ ] 2 flags CTF présents et accessibles
- [ ] 16+ spawns rouge + 16+ spawns bleu
- [ ] 6+ spawns FFA dispersés
- [ ] Compilation sans erreur (zéro leak)
- [ ] FPS >60 dans les zones ouvertes
- [ ] Levelshot TGA 512×512 présent
- [ ] Fichier .arena correct et complet
- [ ] Nom cohérent partout (ut4_neonduct)
- [ ] .pk3 testé et fonctionnel

---

## Journal des décisions
*Les grandes décisions de design sont notées ici avec la date.*

- **[init]** Thème : souterrain industriel néon
- **[init]** Mode : CTF uniquement
- **[init]** Palette néon : cyan principal, violet secondaire, orange accent
