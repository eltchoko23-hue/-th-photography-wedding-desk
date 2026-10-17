# TH Photography — Wedding Desk

Application web responsive avec authentification Supabase et sauvegarde des fiches de mariage dans PostgreSQL/Supabase.

## Configuration obligatoire avant mise en ligne

1. Créez un projet Supabase.
2. Dans **SQL Editor**, exécutez tout le contenu de `supabase-schema.sql`.
3. Dans **Project Settings → API** (ou Connect), copiez l'URL du projet et la clé publique `anon` / publishable.
4. Ouvrez `app.js` et remplacez :
   - `REMPLACER_PAR_SUPABASE_URL` par l'URL de votre projet
   - `REMPLACER_PAR_SUPABASE_ANON_KEY` par la clé publique
   Ne mettez jamais une `service_role` ou clé secrète dans le navigateur.
5. Publiez les fichiers `index.html`, `app.js` et `manifest.json` sur un hébergeur statique HTTPS, par exemple Netlify ou Cloudflare Pages.
6. Ouvrez le site publié, créez le compte responsable et vérifiez qu'un mariage test se sauvegarde et reste présent après reconnexion.

## Gestion de l'équipe
Cette version enregistre les rôles et coordonnées des prestataires dans chaque fiche. La politique de base de données isole les mariages par compte. Pour que plusieurs comptes membres de l'équipe partagent les mêmes mariages, il faut ajouter un modèle d'organisation et des invitations membres : ne partagez pas un mot de passe commun.

## Rappels
Les notifications navigateur de cette version sont vérifiées quand l'application est ouverte. Les notifications garanties en arrière-plan nécessitent un service worker push et un serveur de notifications (par exemple Edge Function + fournisseur push); ce n'est pas configuré dans cette version.

## Limites et sécurité
- Le navigateur utilise uniquement la clé publique Supabase avec Row Level Security.
- Les rappels locaux ne remplacent pas un système push en arrière-plan.
- Faites une sauvegarde régulière via Exporter JSON.
- Pour les données de clients, utilisez des mots de passe uniques et activez la confirmation d'e-mail.
