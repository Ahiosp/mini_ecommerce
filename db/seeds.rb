require "json"
require "open-uri"

# Lire le fichier JSON avec les données
file = File.read(Rails.root.join("db/fixtures/products.json"))
products = JSON.parse(file)

# On supprime tous les produits existants avant d'ajouter les nouveaux produits
Product.destroy_all

products.each do |product_data|
  puts "Traitement du produit : #{product_data['nom']}"

  # Créer un produit sans chercher un produit existant
  product = Product.create(
    nom: product_data["nom"],
    prix: product_data["price"],
    description: product_data["description"]
  )

  # Télécharger et attacher l'image
  image_url = product_data["image"]
  file = URI.open(image_url)
  product.image.attach(io: file, filename: "#{product.nom}.jpg", content_type: "image/jpg")
  file.close

  puts "Produit créé : #{product_data['nom']}"
end
