#!/bin/sh

# Créer la structure du repository
mkdir -p hello_world

# Créer le Dockerfile
cat > hello_world/Dockerfile <<EOF
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
EOF

# Créer la page HTML
cat > hello_world/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Hello World</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f0f0f0;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 {
            color: #03a9f4;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Hello World!</h1>
        <p>Mon premier module personnalisé Home Assistant</p>
    </div>
</body>
</html>
EOF

# Créer le fichier de configuration addon
cat > hello_world/config.json <<EOF
{
  "name": "Hello World Addon",
  "version": "1.0.0",
  "slug": "hello_world",
  "description": "Un addon personnalisé avec interface web Hello World",
  "arch": ["amd64", "armv7", "aarch64"],
  "startup": "application",
  "boot": "auto",
  "ports": {
    "80/tcp": 8080
  },
  "ports_description": {
    "80/tcp": "Web interface"
  },
  "map": ["config:rw"],
  "options": {},
  "schema": {},
  "image": "hello-world-addon-{arch}"
}
EOF

# Créer le fichier de documentation
cat > hello_world/DOCS.md <<EOF
# Hello World Addon

Un module complémentaire personnalisé qui affiche une page web simple.

## Configuration

Aucune configuration nécessaire.
EOF

# Créer le fichier repository.json requis
cat > repository.json <<EOF
{
    "name": "Mon Repository Personnalisé",
    "url": "https://github.com/votre-utilisateur/votre-repo",
    "maintainer": "Votre Nom <votre@email.com>"
}
EOF

# Rendre le script exécutable
chmod +x "$0"

echo "Structure créée avec succès!"
echo "N'oubliez pas de modifier le fichier repository.json avec vos informations"
echo "Ajoutez ce repository dans Home Assistant > Superviseur > Add-ons > ... > Repository"
echo "L'addon 'Hello World Addon' apparaîtra dans la liste des modules complémentaires"