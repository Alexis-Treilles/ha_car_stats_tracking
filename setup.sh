#!/bin/sh

# Créer la structure du repository
mkdir -p hello-world-addon

# Créer le Dockerfile
cat > hello-world-addon/Dockerfile <<EOF
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
EOF

# Créer la page HTML
cat > hello-world-addon/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Hello World</title>
    <meta charset="UTF-8">
</head>
<body>
    <h1>Hello World!</h1>
    <p>Mon premier module personnalisé Home Assistant</p>
</body>
</html>
EOF

# Créer le fichier de configuration addon
cat > hello-world-addon/config.json <<EOF
{
  "name": "Hello World Addon",
  "version": "1.0.0",
  "slug": "hello_world",
  "description": "Un addon personnalisé avec interface web Hello World",
  "arch": ["amd64", "armv7", "aarch64"],
  "startup": "application",
  "boot": "auto",
  "ports": {
    "80/tcp": 80
  },
  "map": ["config:rw"],
  "options": {},
  "schema": {},
  "image": "hello-world-addon-{arch}"
}
EOF

# Créer le fichier de documentation
cat > hello-world-addon/DOCS.md <<EOF
# Hello World Addon

Un module complémentaire personnalisé qui affiche une page web simple.

## Configuration

Aucune configuration nécessaire.
EOF

# Rendre le script exécutable
chmod +x "$0"

echo "Structure créée avec succès!"
echo "Ajoutez ce repository dans Home Assistant > Superviseur > Add-ons > ... > Repository"
echo "L'addon 'Hello World Addon' apparaîtra dans la liste des modules complémentaires"